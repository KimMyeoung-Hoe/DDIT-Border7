
let html ="";
$.ajax({
    url: "/api/news",               
    method: "GET",                           
    dataType: "json",                         
	success: function(resp){
		console.log(resp[0]);
		for(let i = 0; i<5; i++){
			html += `<li><a href="\${resp[i].kotraNewsUrl}" target="_blank" >\${resp[i].newsTitl}</a></li>`;
		}
		$('#news').prepend(html)
	}
})

