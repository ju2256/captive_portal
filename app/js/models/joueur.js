var joueur = (function () {
    
    function getJoueurs(){
        return $.ajax( {
			url :           'app/php/joueurs.php',
			type:           'post',
			timeout:        5000,
			cache:          false,  
			data:           { "action": "getJoueurs" }
		} )
    };
    
    function addJoueur(data){
        return $.ajax( {
			url :           'app/php/joueurs.php',
			type:           'post',
			timeout:        5000,
			cache:          false, 
            datatype :      'json',
			data:           { "action": "addJoueur", "data": data }
		} )
    };
    
    function updateJoueur(data){
        return $.ajax( {
			url :           'app/php/joueurs.php',
			type:           'post',
			timeout:        5000,
			cache:          false, 
			data:           { "action": "updateJoueur", "data" : data }
		} )
    };
    
    function deleteJoueur(id){
        return $.ajax( {
			url :           'app/php/joueurs.php',
			type:           'post',
			timeout:        5000,
			cache:          false, 
			data:           { "action": "deleteJoueur", "id": id }
		} )
    };
    
    function deleteAllJoueur(){
        return $.ajax( {
			url :           'app/php/joueurs.php',
			type:           'post',
			timeout:        5000,
			cache:          false,  
			data:           { "action": "deleteAllJoueur" }
		} )
    };
    
    function getMacFromLan(){
        return $.ajax( {
			url :           'app/php/mac.php',
			type:           'post',
			timeout:        5000,
			cache:          false,  
			data:           { "action": "getMacFromLan" }
		} )
    };
    
    function getJoueurFromMac(mac){
        return $.ajax( {
			url :           'app/php/joueurs.php',
			type:           'post',
			timeout:        5000,
			cache:          false,  
			data:           { "action": "getJoueurFromMac", "mac":mac }
		} )
    };
    
    function getStats(){
        return $.ajax( {
			url :           'app/php/joueurs.php',
			type:           'post',
			timeout:        5000,
			cache:          false,  
			data:           { "action": "getStats" }
		} )
    };
    
    return {
        getJoueurs: getJoueurs,
        addJoueur: addJoueur,
        updateJoueur: updateJoueur,
        deleteJoueur: deleteJoueur,
        deleteAllJoueur: deleteAllJoueur,
        getMacFromLan : getMacFromLan,
        getJoueurFromMac : getJoueurFromMac,
        getStats : getStats
	};
    
})();