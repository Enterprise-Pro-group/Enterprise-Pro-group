const openPopup = document.getElementById("openPopup");
const popupOverlay = document.getElementById("popupOverlay");
const closePopup = document.getElementById("closePopup");
const closeCard = document.getElementById("closeCard");

openPopup.addEventListener("click", function(){
  popupOverlay.classList.add("active");
});

closePopup.addEventListener("click", function(){
  popupOverlay.classList.remove("active");
});

closeCard.addEventListener("click", function(){
  popupOverlay.classList.remove("active");
});

popupOverlay.addEventListener("click", function(e){
  if(e.target === popupOverlay){
    popupOverlay.classList.remove("active");
  }
});