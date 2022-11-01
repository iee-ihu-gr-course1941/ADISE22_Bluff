
window.onload = function() {
    //buildDeck();
    player1_cards();
    player2_cards();
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
function player1_cards(){
    $.ajax({url: "bluff.php/player1_cards", method :'get', success: display_p1cards});
}
function player2_cards(){
  $.ajax({url: "bluff.php/player2_cards", method :'get', success: display_p2cards});
}
  function display_p1cards(data){
    for(var i=0;i<data.length;i++)
    {
      var url = 'cards/'+data[i].PLAYER1_CARDS_ID+'.png'; 
      var image = new Image();
      image.src = url;
      document.getElementById('dealer-cards').appendChild(image); 
      
    }
  }  
  function display_p2cards(data){
    for(var i=0;i<data.length;i++)
    {
      var url = 'cards/'+data[i].PLAYER2_CARDS_ID+'.png'; 
      var image = new Image();
      image.src = url;
      document.getElementById('your-cards').appendChild(image); 
      
    }
  } 


