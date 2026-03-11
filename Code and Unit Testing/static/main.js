
// sidebar
let sidebarOpen = true;

function toggleSidebar() {
  sidebarOpen ? closeSidebar() : openSidebar();
}
function openSidebar() {
  document.getElementById('sidebar').classList.remove('collapsed');
  document.getElementById('sidebarBackdrop').classList.add('visible');
  sidebarOpen = true;
}
function closeSidebar() {
  document.getElementById('sidebar').classList.add('collapsed');
  document.getElementById('sidebarBackdrop').classList.remove('visible');
  sidebarOpen = false;
}

// collapse on narrow viewports by default
if (window.innerWidth < 700) closeSidebar();

// profile dropdown
function toggleProfile(e) {
  e.stopPropagation();
  const dd = document.getElementById('profileDropdown');
  const chevron = document.getElementById('profileChevron');
  const isOpen = dd.classList.toggle('open');
  chevron.classList.toggle('open', isOpen);
}

document.addEventListener('click', () => {
  document.getElementById('profileDropdown').classList.remove('open');
  document.getElementById('profileChevron').classList.remove('open');
});

// chat history
function selectChat(el, title) {
  document.querySelectorAll('.chat-history-item').forEach(i => i.classList.remove('active'));
  el.classList.add('active');
  document.getElementById('chatTitle').textContent = title;
  if (window.innerWidth < 700) closeSidebar();
}

function newChat() {
  document.querySelectorAll('.chat-history-item').forEach(i => i.classList.remove('active'));
  document.getElementById('chatTitle').textContent = 'New conversation';
  document.getElementById('messages').style.display = 'none';
  document.getElementById('welcomeState').style.display = 'flex';
  if (window.innerWidth < 700) closeSidebar();
}

// input
function autoResize(el) {
  el.style.height = 'auto';
  el.style.height = Math.min(el.scrollHeight, 160) + 'px';
}

function handleKey(e) {
  if (e.key === 'Enter' && !e.shiftKey) { e.preventDefault(); sendMessage(); }
}

// mic 
let micActive = false;
function toggleMic() {
  micActive = !micActive;
  document.getElementById('micBtn').classList.toggle('active', micActive);
}

async function handleFile(e) {
  const file = e.target.files[0];
  if (!file) return;

  showMessages();
  appendUserMessage(file.name);

  const formData = new FormData();
  formData.append("receipt", file);

  try {
    const response = await fetch("/scan", {
      method: "POST",
      body: formData
    });

    const data = await response.json();

    if (data.error) {
      simulateReply(data.error);
      return;
    }

    displayReceiptInChat(data);

  } catch (err) {
    simulateReply("receipt cannot be processed.");
  }

  e.target.value = '';
}
function displayReceiptInChat(data) {

  let message = `
    <p> Receipt Scanned Successfully</p>

    <p><strong>Store:</strong></p>
    <input id="StoreName" value="${data.store_name || ''}">
    
    <br><br>
  
  <p><strong>Address:</strong></p>
    <input id="StoreAddress" value="${data.store_address || ''}">

  <p><strong>City:</strong></p>
    <input id="StoreCity" value="${data.store_city || ''}">


  <p><strong>Postcode:</strong></p>
  <input id="StorePostcode" placeholder="Enter postcode">  


    <p><strong>Items:</strong></p>




  `;

  data.items.forEach((item) => {
    message += `
      <div style="margin-bottom:6px;">
        <input class="ProductName" value="${item.product_name}">
        <input class="ProductPrice" value="${item.product_price}" >
      </div>
    `;
  });

  message += `
    <br>
    <button onclick="saveReceipt()">Confirm & Save</button>
  `;

  appendBotMessageHTML(message);
}

async function saveReceipt() {
  const store_name = document.getElementById("StoreName").value.trim();
  const store_address = document.getElementById("StoreAddress").value.trim();
  const product_names = document.querySelectorAll(".ProductName");
  const product_prices = document.querySelectorAll(".ProductPrice");
  const store_postcode = document.getElementById("StorePostcode").value.trim();
  const  store_city = document.getElementById("StoreCity").value.trim();

 

  const items = [];

  for (let i = 0; i < product_names.length; i++) {
    const name = product_names[i].value.trim();
    const price = parseFloat(product_prices[i].value);

    if (!name || isNaN(price) || !store_postcode || !store_city || !store_address || !store_name) {
      simulateReply("Enter valid details for all items .");
      return;
    }

    items.push({
      product_name: name,
      product_price: price
    });
  }

  try {
    const response = await fetch("/save-receipt", {
      method: "POST",
      headers: {
        "Content-Type": "application/json"
      },
      body: JSON.stringify({
        store_name,
        store_address,
        store_postcode,
        store_city,
        items
        
      })
    });

    if (!response.ok) {
      throw new Error("Failed to save receipt");
    }

    const result = await response.json();
    simulateReply("Receipt is successfully saved to database.");

  } catch (error) {
    console.error(error);
    simulateReply("Error saving receipt. Please try again.");
  }
}

function appendBotMessageHTML(htmlContent) {

  const messages = document.getElementById('messages');
  const typing = document.getElementById('typing');
  if (typing) typing.style.display = 'none';

  const msg = document.createElement('div');
  msg.className = 'message ai';

  msg.innerHTML = `
    <div class="msg-avatar ai">✦</div>
    <div>
      <div class="msg-content">
        ${htmlContent}
      </div>
      <div class="msg-meta">ShopQuick AI · Just now</div>
    </div>
  `;

  messages.appendChild(msg);
  messages.appendChild(typing);
  messages.scrollTop = messages.scrollHeight;
}

// send 
async function sendMessage() {
  const input = document.getElementById('userInput');
  const text = input.value.trim();
  if (!text) return;
  input.value = ''; input.style.height = 'auto';
  showMessages();
  appendUserMessage(text);

  const messages = document.getElementById('messages');
  const typing = document.getElementById('typing');
  messages.appendChild(typing); // move to bottom
  messages.scrollTop = messages.scrollHeight;

  try {
    // send to flask using fetch 
    const response = await fetch("/chat", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ message: text })
    });

    const data = await response.json();

    // pass to reply 
    reply(data.reply);

  } catch (error) {
    console.error("Error calling Flask:", error);
    reply("Sorry, I'm having trouble connecting to the server.");
  } finally {
    if (typing) typing.style.display = 'none';
  }

  if (data.popup) {
    // will show the real popup instead 
    alert(`🎉 You saved $${data.savings}!`);
  }

}

// when u choose a chat on newchat
function chipSend(text, reply) {
  showMessages();
  appendUserMessage(text);
  simulateReply(reply);
}

function showMessages() {
  document.getElementById('messages').style.display = 'flex';
  document.getElementById('welcomeState').style.display = 'none';
}

// user messages
function appendUserMessage(text) {
  const messages = document.getElementById('messages');
  const typing = document.getElementById('typing');
  if (typing) typing.style.display = 'none';
  const msg = document.createElement('div');
  msg.className = 'message user';
  msg.innerHTML = `
        <div class="msg-avatar user">U</div>
        <div>
          <div class="msg-content">${escapeHtml(text)}</div>
          <div class="msg-meta">Just now</div>
        </div>`;
  messages.appendChild(msg);
  messages.appendChild(typing);
  messages.scrollTop = messages.scrollHeight;
}

// ai replies
function simulateReply(text) {
  const messages = document.getElementById('messages');
  const typing = document.getElementById('typing');
  messages.scrollTop = messages.scrollHeight;
  setTimeout(() => {
    if (typing) typing.style.display = 'none';
    const msg = document.createElement('div');
    msg.className = 'message ai';
    msg.innerHTML = `
          <div class="msg-avatar ai">🛒</div>
          <div>
            <div class="msg-content">${escapeHtml(text)}</div>
            <div class="msg-meta">ShopQuick AI · Just now</div>
          </div>`;
    messages.appendChild(msg);
    messages.appendChild(typing);
    messages.scrollTop = messages.scrollHeight;
  }, 1800);
}

// actual ai reply 
function reply(text) {
  const messages = document.getElementById('messages');

  const msg = document.createElement('div');
  msg.className = 'message ai';
  msg.innerHTML = `
    <div class="msg-avatar ai">🛒</div>
    <div>
      <div class="msg-content">${(text)}</div>
      <div class="msg-meta">ShopQuick AI · Just now</div>
    </div>`;

  messages.appendChild(msg);
  messages.scrollTop = messages.scrollHeight;
}

function escapeHtml(str) {
  return str.replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;');
}

// hide typing indicator on page load? 
//document.getElementById('typing').style.display = 'none';