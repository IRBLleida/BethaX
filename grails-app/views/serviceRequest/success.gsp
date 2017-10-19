<%@ page import="org.irblleida.bethax.User" %>
<!DOCTYPE html>
<html>
<head>
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.100.2/css/materialize.min.css">
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <style>
    .mrue {
        background-image: url("${assetPath(src: '/mrue.png')}");
        background-repeat: no-repeat;
        background-size: cover;
        border-radius: 10%;
    }
    .aligned {
        display: inline-flex;
        vertical-align: middle;
    }

    .aligned > .material-icons {
        margin-right: 10px;
    }
    </style>
</head>
<body>
<nav class="light-blue lighten-1" role="navigation">
    <div class="nav-wrapper container"><a id="logo-container" href="#" class="brand-logo">UBiostat</a>
        <ul class="right hide-on-med-and-down">
            <li><a href="#">IRBLleida</a></li>
        </ul>

        <ul id="nav-mobile" class="side-nav">
            <li><a href="#">IRBLleida</a></li>
        </ul>
        <a href="#" data-activates="nav-mobile" class="button-collapse"><i class="material-icons">menu</i></a>
    </div>
</nav>
<div class="section no-pad-bot" id="index-banner">
    <div class="container">
        <div class="row">
            <h2>Dades rebudes correctament!</h2>
        </div>
    </div>
</div>
<footer class="page-footer orange">
    <div class="container">
        <div class="row">
            <div class="col l6 s12">
                <h5 class="white-text">Unitat de Bioestadística (UBiostat)</h5>
                <p class="grey-text text-lighten-4">
                    La Unitat de Bioestadística (UBiostat), ubicada a la quarta planta de l’edifici Biomedicina II, té la missió de contribuir a generar coneixement per millorar la salut. Els mètodes estadístics són essencials per dissenyar estudis, analitzar dades i interpretar els resultats. A la UBiostat es treballa amb els Investigadors per convertir les dades en informació útil per fer avançar la recerca. La UBiostat depèn de la direcció de l'IRBLLEIDA.
                </p>


            </div>
            <div class="col l6 s12">
                <h5 class="white-text">Equip</h5>
                <div class="carousel carousel-slider center" data-indicators="true">
                    <g:each var="user" in="${org.irblleida.bethax.User.list()}">
                        <div class="carousel-item mrue white-text" href="#mrue">
                            <h2><span class="yellow-text lighten-5">Dr.</span> ${user}</h2>
                            <p class="white-text">
                                <a class="white-text aligned" href="mailto:mrue@irblleida.cat">
                                    <i class="material-icons">email</i> ${user.username}
                                </a>
                            </p>
                            <p class="white-text">
                                <a class="white-text aligned" href="http://www.researcherid.com/rid/B-5663-2009" target="_blank">
                                    <i class="material-icons">subtitles</i> ResearcherID
                                </a>
                            </p>
                        </div>
                    </g:each>
                </div>
            </div>
        </div>
    </div>
    <div class="footer-copyright">
        <div class="container">
            Desenvolupat amb <i class="material-icons prefix">favorite_border</i> per <a class="orange-text text-lighten-3" href="http://www.irblleida.org/ca/index.php?p=webs/serveis_cientificotec/detall_servei.php&id=7" target="_blank">UBiostat</a>.
        </div>
    </div>
</footer>


<script type="text/javascript" src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.100.2/js/materialize.min.js"></script>
<script>
    $(document).ready(function(){
        $('.carousel').carousel({fullWidth: true});
        var carouselAutoplay = setInterval(function(){
            $('.fa-angle-right').click();
        }, 7000);
        setInterval(function() {
            $('.carousel').carousel('next');
        }, 10000); // every 2 seconds

        $('input.autocomplete').autocomplete({
            data: {
                "IRBLleida": 'http://www.irblleida.org/arxius/imatges/logos/300-IRBok.jpg',
                "ICS Lleida": 'https://ccooprimarialleida.files.wordpress.com/2015/11/ics.png?w=780',
                "GSS": 'http://identitatcorporativa.gencat.cat/web/.content/Documentacio/descarregues/dpt/COLOR/Salut/gss.jpg',
                "UdL": 'http://udltreball.udl.cat/export/sites/UdLTreball/.galleries/imagenes-estructura/UdL.jpg',
                "CatSalut": 'https://upload.wikimedia.org/wikipedia/commons/thumb/6/6b/CatSalut.svg/1200px-CatSalut.svg.png',
                "HUGTP": 'http://identitatcorporativa.gencat.cat/web/.content/Documentacio/descarregues/dpt/COLOR/Salut/hgtp.jpg',
                "Parc Taurí": 'https://www.tauli.cat/tauli/images/recursos/logo.png',
                "GOC": null
            },
            limit: 5, // The max amount of results that can be shown at once. Default: Infinity.
            onAutocomplete: function(val) {
                // Callback function when value is autcompleted.
            },
            minLength: 1, // The minimum length of the input for the autocomplete to start. Default: 1.
        });
    });

</script>
</body>
</html>
