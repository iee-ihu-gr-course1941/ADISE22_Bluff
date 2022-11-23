

$(function(){
    draw_selection();
    fill_cards_start();
})

function draw_selection(){
    var t="<form action='#' onsubmit='show_me()' method='POST'>";
    t+="<label for='Your Cards:'>Your Cards:</label>";
    t+="<select id='cards' name='cards' id='cards'>";
    t+='</select>';
    t+="<br>";
    t+="<br>";
    t+="<input type='submit' onclick='show_selected()' value='Play this card'>";
    t+="</form>";
    $('#select-list').html(t);
}
function fill_cards_start(){
    $.ajax(
        {   
            url:"bluff.php/show_cards/player1",
            success: fill_cards
        }

    );
}
function fill_cards(data){
    for(var i=0;i<data.length;i++){
        var o=data[i];
        var x = document.getElementById("cards");
        var option = document.createElement("option");
        option.text = o.card_text+" "+o.card_symbol;
        x.add(option);

        

    }

}
function show_me(){
    var e = document.getElementById("cards");
    var value = e.value;
    var text = e.options[e.selectedIndex].text;
    alert(text);
}
