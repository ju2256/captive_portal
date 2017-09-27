$(document).ready(function() {
    // au clic sur le bouton, appel "updateMac()", lancement du script de detection de l'adresse mac. Si celui ci echoue (retour = false), affichage
    // du formulaire de saisie de l'adrese mac par l'utilisateur.
    $("#pseudo-ok-btn").click(function(){
        var id = $("#pseudo-list option:selected").val();
        if(id !== ''){
            var jqXHR = joueur.getMacFromLan()
            .done(function(data){
                if(jQuery.parseJSON(data) !== false){ 
                    data = data.replace('"','');
                    data = data.replace('"','');
                    updateMac(id, data);
                } else {
                    displayMacForm(id);
                }
            });
        }
    });
	$("#inscription-state-refresh").click(function(){
		window.location.replace("http://oufs-lan.org/CODE/JS/nepaseffacer.html");
	});
	
    // affichage du texte indiquant à l'utilisateur que le script de detection de l'adresse mac est en cours de traitement
    $(document)
      .ajaxStart(function () {
        $("#pseudo-ok-btn").text("en cours...");
      })
      .ajaxStop(function () {
        $("#pseudo-ok-btn").text("suivant");
      });
	if (document.all) {
        var ieText = "Navigateur non supporté. (nécéssite Internet Explorer v 11 minimum, Chrome, Firefox, Safari)";
        $("body").text(ieText);
    } else {
		start();
	}
});

// fonction d'affichage fenetre etat de l incription
function displayInscriptionState(results){
	$('#pseudo').css("display","none");
	$('#inscription-state').css("display","block");
	$('#inscription-state-pseudo').html(results[0].pseudo);
	$('#inscription-state-mac').html(results[0].mac);
	if(results[0].paiement === ''){
		$('#inscription-state-paiement').html("0€");
		$('#tarifs').css("display","block");
	} else { 
		$('#inscription-state-paiement').html(results[0].paiement + "€");
	}
	if(results[0].etat === '1'){
		$('#inscription-state-etat').html('<span style="color: green; font-weight: bold;">Activé</span>');
		$('#billing-ok').css("display","block");
	} else {
		$('#inscription-state-etat').html('<span style="color: red;  font-weight: bold;">Non activé</span>');
		$('#billing-ko').css("display","block");
		$('#inscription-modify').attr('data-id', results[0].id);
	}
}
// fonction d'affichage des pseudo des joueurs présents dans la base de données
function displayPseudo(){
	var jqXHR = joueur.getJoueurs()
	.done(function(data){
		var joueurs = jQuery.parseJSON(data);
		var html = '';
		$.each(joueurs, function(key, item){
			if(item.etat !== '1'){
				html += '<option value="' + item.id + '">' + item.pseudo + '</option>';
			}
		});
		$('#pseudo-list').append(html);
	});
}
function start(){
	// recuperation de l'adresse mac
	var jqXHR = joueur.getMacFromLan()
	.done(function(data){
		// test si la detection <> false
		if(jQuery.parseJSON(data) !== false){ 
			//on cherche si la mac est deja presente dans la base
			var jqXHR = joueur.getJoueurFromMac(data)
			.done(function(data){
				var results = jQuery.parseJSON(data);
				// si présente affichage "etat inscription"
				if(results.length !== 0){
					displayInscriptionState(results);
				// sinon affichage "choix du pseudo"
				}else{
					$('#pseudo').css("display","block");
					displayPseudo();
				}
			});
		} else {
			$('#pseudo').css("display","block");
			displayPseudo();
		}
	});
}
// fonction d'enregistrement de l'adresse mac de l'utilisateur dans la base et affichage de la fenetre de confirmation
function updateMac(id, mac){
    var clientMacAdresse = mac;
    var data = {};
    data.field = 'mac';
    data.value = mac ;
    data.id = id;
    var jsonText = JSON.stringify(data);
    var jqXHR = joueur.updateJoueur(jsonText)
	.done(function(data){
		if(data === 'erreur'){
			$("#myModal").modal('show');
			$("#modal-title").append("<p>Ouch !</p>");
			$("#modal-body").append("erreur d'enregistrement dans la base ...");
		} else {
			start();
		}
		
	});
}