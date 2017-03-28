var BREWERIES = {};
BREWERIES.show = function(){
/*        $("#breweries").html("Number of breweries: "+breweries.length);
        $('#breweries').html("Hello from Javascript!");
        var brewery_list = [];
        $.each(BREWERIES.list, function (index, brewery) {
            brewery_list.push('<li>'+brewery['name']+'</li>')
        });
        $("#breweries").html('<ul>'+brewery_list.join('')+'</ul>'); */
        $("#brewerytable tr:gt(0)").remove();
        var table = $("#brewerytable");
        $.each(BREWERIES.list, function(index, brewery){
            table.append('<tr>'
                +'<td>'+brewery['name']+'</td>'
                +'<td>'+brewery['year']+'</td>'
                +'<td>'+brewery['beercount']+'</td>'
                +'<td>'+brewery['ratingcount']+'</td>'
                +'</tr>');
        });
};

BREWERIES.sort_by_name = function(){
    BREWERIES.list.sort( function(a,b){
        return a.name.toUpperCase().localeCompare(b.name.toUpperCase());
    });
};

BREWERIES.sort_by_year = function(){
    BREWERIES.list.sort( function(a,b){
        return a.year - b.year
    });
};

BREWERIES.sort_by_beercount = function(){
    BREWERIES.list.sort( function(a,b){
        return b.beercount - a.beercount
    });
};

BREWERIES.sort_by_ratingcount = function(){
    BREWERIES.list.sort( function(a,b){
        return b.ratingcount - a.ratingcount
    });
};

BREWERIES.reverse = function(){
    BREWERIES.list.reverse();
}

$(document).ready(function (){
    if($("#brewerytable").length>0){
    $("#reverse").click(function (e) {
        BREWERIES.reverse();
        BREWERIES.show();
        e.preventDefault();
    });

    $("#name").click(function (e){
        BREWERIES.sort_by_name();
        BREWERIES.show();
        e.preventDefault();
    });

    $("#year").click(function(e){
        BREWERIES.sort_by_year();
        BREWERIES.show();
        e.preventDefault();
    });

    $("#beers").click(function(e){
        BREWERIES.sort_by_beercount();
        BREWERIES.show();
        e.preventDefault();
    });

    $("#ratings").click(function(e){
        BREWERIES.sort_by_ratingcount();
        BREWERIES.show();
        e.preventDefault();
    });

    $.getJSON('breweries.json', function (breweries){
        BREWERIES.list = breweries;
        BREWERIES.sort_by_name();
        BREWERIES.show();
        
        console.log("Hello console!")
    });
    }
});