
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

    // file upload 
    function handleFile(e) {
      const file = e.target.files[0];
      if (!file) return;
      showMessages();
      appendUserMessage(file.name);
      simulateReply('reading receipt.');
      e.target.value = '';
    }

    // send 
    function sendMessage() {
      const input = document.getElementById('userInput');
      const text = input.value.trim();
      if (!text) return;
      input.value = ''; input.style.height = 'auto';
      showMessages();
      appendUserMessage(text);
      simulateReply('chat input.');
    }

    // when u choose a chat on newchat
    function chipSend(text) {
      showMessages();   
      appendUserMessage(text);
      simulateReply('newchat .');
    }

    function showMessages() {
      document.getElementById('messages').style.display = 'flex';
      document.getElementById('welcomeState').style.display = 'none';
    }

    // user messages
    function appendUserMessage(text) {
      const messages = document.getElementById('messages');
      const typing = document.getElementById('typing');
      typing.remove();
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
        typing.remove();
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

    function escapeHtml(str) {
      return str.replace(/&/g,'&amp;').replace(/</g,'&lt;').replace(/>/g,'&gt;');
    }
