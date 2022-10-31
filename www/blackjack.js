
window.onload = function() {
    buildDeck();
    

}

function buildDeck(){
for (var i=0; i<24; i++)
{
var url = 'cards/BACK.png'; 
var image = new Image();
image.src = url;
document.getElementById('dealer-cards').appendChild(image);
}
for (var i=0; i<24; i++)
{
var url = 'cards/BACK.png'; 
var image = new Image();
image.src = url;
document.getElementById('your-cards').appendChild(image);
}
}



