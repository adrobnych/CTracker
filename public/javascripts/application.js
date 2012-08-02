
var g_draw = {};

$(document).ready(function () {

		var data;
		var chart;	
		var options;
		var jsonData	

		function draw_line_chart(){
				if (document.location.pathname == "/countries"){
					jsonData = $.ajax({
          url: "/trips/chart_data?source=countries",
          dataType:"json",
          async: false
          }).responseText;

					options = {
          	title: 'Visited countries: last 6 months'
        	}
            
				}
				if ((document.location.pathname == "/") || (document.location.pathname == "/currencies")){
					jsonData = $.ajax({
          url: "/trips/chart_data?source=currencies",
          dataType:"json",
          async: false
          }).responseText;
          
					options = {
          	title: 'Collected currencies: last 6 months'
        	}
				}

        // Create our data table out of JSON data loaded from server.
		    data = new google.visualization.DataTable(jsonData);
				chart = new google.visualization.LineChart(document.getElementById('chart_div'));
				chart.draw(data, options);
    }

		function draw_pie_chart(){
				if (document.location.pathname == "/countries"){
					jsonData = $.ajax({
          url: "/trips/totals_data?source=countries",
          dataType:"json",
          async: false
          }).responseText;

					options = {
          	title: 'Countries: totals'
        	};
            
				}
				if ((document.location.pathname == "/") || (document.location.pathname == "/currencies")){
					jsonData = $.ajax({
          url: "/trips/totals_data?source=currencies",
          dataType:"json",
          async: false
          }).responseText;

					options = {
          	title: 'Currencies: totals'
        	};
          
				}

        // Create our data table out of JSON data loaded from server.
		    data = new google.visualization.DataTable(jsonData);
				chart = new google.visualization.PieChart(document.getElementById('chart_div2'));
        chart.draw(data, options);

    }

    draw_line_chart();
		draw_pie_chart();
    g_draw.line = draw_line_chart;
    g_draw.pie = draw_pie_chart;


		$("#checkbox_master").change(function(e) {
				$('form').find('input[type=checkbox]:visible').prop('checked', $(e.currentTarget).prop('checked'));
		});


  
  $("#filter").keyup(function() {
		
		var rows = $(".named_row"); 
    var filterExp = this.value.toLowerCase();
    
		rows.each(function(index) {
      var name = $(this).children().eq(1).text().toLowerCase();  

      if (name.match(filterExp)) {
        this.style.display = "table-row";
      } else {
        this.style.display = "none";
      }
    });

    
  });

	
	}
);
