

const popup = document.getElementById("sharePopup");
const openBtn = document.getElementById("openShareModal");
const closeBtn = document.getElementById("closeShareModal");
const copyBtn = document.getElementById("copyBtn");
const shareLink = document.getElementById("shareLink");




openBtn.addEventListener("click", function() {
  popup.classList.add("show");
});




closeBtn.addEventListener("click", function() {
  popup.classList.remove("show");
});




copyBtn.addEventListener("click", function() {

  shareLink.select();

  navigator.clipboard.writeText(shareLink.value);

  copyBtn.innerText = "Copied!";

});