function convertPL(x){
	var jscodes=new Array("%u0104","%u0105","%u0106","%u0107","%u0118","%u0119","%u0141","%u0142","%u0143","%u0144","%D3","%F3","%u015A","%u015B","%u0179","%u017A","%u017B","%u017C");
	var chars=new Array("Ą","ą","Ć","ć","Ę","ę","Ł","ł","Ń","ń","Ó","ó","Ś","ś","Ź","ź","Ż","ż");
	
	for(var i=0; i<chars.length; i++){
	    while (x.indexOf(jscodes[i]) !== -1) {
	    	x = x.replace(jscodes[i], chars[i]);
	    }
	}
   // alert(x +":: CONVERT");	
    return x;
	
	
}