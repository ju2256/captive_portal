$(document).ready(function() {    
    // supprimer un joueur
    $('#tJoueurs').on('click', "#btn-delete", function(){
		var answer = confirm("Supprimer ?")
		if (answer){
				var jqXHR = joueur.deleteJoueur($(this).data('id'))
				.done(function(data){
					displayJoueurs();
				});
		}
    });
    // ajouter un joueur
    $('#tJoueurs').on('click', "#btn-add", function(){
        var emptyForm = '';
        var data = {};
        ($('#newJoueur #pseudo').val().length != 0) ? data.pseudo = $('#newJoueur #pseudo').val() : emptyForm += 'pseudo';
        data.etat = $('#newJoueur #etat').prop("checked")? "1" : "0";
        if(emptyForm != ''){
            alert('Veuillez remplir le(s) champ(s): ' + emptyForm);
        } else {
            var jsonText = JSON.stringify(data);
            var jqXHR = joueur.addJoueur(jsonText)
            .done(function(){
                displayJoueurs();
            });
        }
        
    });
    // mettre à jour un joueur (champs pseudo statut mac paiement etat)
    $('#tJoueurs').on('change', "#pseudo, #statut, #mac, #paiement, #etat", function(){
        if($(this).hasClass("new") != true){
             var data = {};
             data.field = $(this).attr("id");
             data.id = $(this).attr("data-id");
             switch(data.field){
                case 'etat':
                    $(this).prop('checked') === true ? data.value = '1': data.value = '0';
                break;
                default:
                    data.value = $(this).val();
             }
             var jsonText = JSON.stringify(data);
             var jqXHR = joueur.updateJoueur(jsonText)
             .done(function(){
                 displayJoueurs();
             });
         }
    });
    // deconnexion de l'interface admin
    $('#disconnect').click(function(){
        $(location).attr('href','admin.html?action=disconnect');
    });
    // export excel
    $('#excel').click(function(){
		window.open('../app/php/export.php');
	});
    // redirections vers la page d'inscription
    $('#inscription').click(function(){
        $(location).attr('href','index.html');
    });
	// redirections vers la page d'inscription
    $('#phpmyadmin').click(function(){
        $(location).attr('href','phpmyadmin/');
    });
    // affichage de la fenetre modale de mise à jour des données depuis le site internet
    $('#reset').click(function(){
        $('#razModal').modal('show');
    });
    // bouton annuler de la fenetre modale
    $('#razModal .deny').click(function(){
        $('#razModal').modal('hide');
    });
    // vidange de la table "users" et appel de la fonction "refreshJoueursFromWeb"
    $('#razModal .confirm').click(function(){
         var jqXHR = joueur.deleteAllJoueur()
             .done(function(){
                 refreshJoueursFromWeb();
                 displayJoueurs();
             });
    });
    $(document)
		.ajaxStart(function () { $("#working").css("display","inline-block"); })
		.ajaxStop(function () { $("#working").css("display","none"); });
    // lancement de la fonction d'affichage des joueurs
    displayJoueurs();
});
// appel du script "inscripts.php" (parse la page inscriptions du site et insere le contenu dans la table "users")
function refreshJoueursFromWeb(){
    $.ajax({
        url: "app/php/inscrits.php",
        async : false
    }).done(function() {
      console.log("refreshed");
    });
}
// fonction qui affiche le tableau des joueurs
function displayJoueurs(){
	var jqXHR = joueur.getJoueurs()
        .done(function(data){
            var joueurs = jQuery.parseJSON(data);
            var html = '';
            $.each(joueurs, function(key, item){
                html += '<tr>';
                html += '   <td><input id="pseudo" class="pseudo" type="text" value="' + item.pseudo + '"  data-id="' + item.id + '"></td>';
                html += '   <td>';
                html += '       <select id="statut" class="statut" data-id="' + item.id + '">';
                html += '           <option id="empty" value="empty"></option>';
                html += '           <option id="staff" value="staff" ';
                (item.statut === 'staff')    ? html += 'selected>staff</option>'    :html += '>staff</option>'
                html += '           <option id="adhérent" value="adhérent" ';
                (item.statut === 'adhérent') ? html += 'selected>adhérent</option>' :html += '>adhérent</option>';
                html += '           <option id="non adhérent" value="non adhérent" ';
                (item.statut === 'non adhérent') ? html += 'selected>non adhérent</option>' :html += '>non adhérent</option>';
                html += '        </select>';
                html += '   </td>';
                html += '   <td><input id="mac"    class="mac"     type="text" value="' + item.mac + '"  data-id="' + item.id + '"></td>';
                html += '   <td><input id="paiement" class="paiement" type="text" value="' + item.paiement + '" data-id="' + item.id + '"></td>';
                (item.etat === '1') ? html += '   <td class="etat etat-ok">' : html += '   <td class="etat etat-ko">' ;
                html+= '<input id="etat" class="etat" type="checkbox" data-id="' + item.id + '" value="' + item.etat + '" ';
                (item.etat === '1') ? html += 'checked value="1">' : html += ' value="0">';
                html += '   <td id="actions" class="actions"><button type="button" id="btn-delete" class="btn btn-danger btn-xs btn-action" data-id="' + item.id + '">x</button></td>';
                html += '</tr>';
            });
            html += '<tr id="newJoueur">';
            html += '   <td><input id="pseudo" class="pseudo new" type="text" value=""></td>';
            html += '   <td>';
            html += '       <select id="statut" class="statut new">';
            html += '           <option id="empty" value="empty"></option>';
            html += '           <option id="staff" value="staff">staff</option>';
            html += '           <option id="staff" value="adhérent">adhérent</option>';
            html += '           <option id="staff" value="non adhérent">non adhérent</option>';
            html += '        </select>';
            html += '   </td>';
            html += '   <td><input id="mac"    class="mac new"     type="text" value=""></td>';
            html += '   <td><input id="paiement" class="paiement new" type="text" value=""></td>';
            html += '   <td><input id="etat" class="etat new" type="checkbox" value="">';
            html += '   <td id="actions" class="actions"><button type="button" id="btn-add" class="btn btn-success btn-xs btn-action">+</button></td>';
            html += '</tr>';
            $('#content').html(html);
        });
    
    var jqXHR = joueur.getStats()
        .done(function(data){
            var stats = jQuery.parseJSON(data);
            var total = 0;
            var html = '<u><b>Statut des Joueurs</b></u>:';
            $.each(stats, function(key, item){
                html += " ";
                (item.statut === '')? html += "non renseignés" : html += item.statut;
                html += " = "  + item.value;
                total = total +  parseInt(item.value);
            });
             html += " <i>total: " + total + "</i>";
            $("#stats").html(html);
            
        });
}