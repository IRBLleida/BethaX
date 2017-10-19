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
        <g:form action="save" class="col s12">
            <div class="row">
                <div class="col s12">
                    <h4>Dades del sol·licitant</h4>
                </div>
            </div>
            <div class="row">
                <div class="input-field col s6">
                    <i class="material-icons prefix">account_circle</i>
                    <g:textField name="name" value="${name}" class="validate" required="required" />
                    <label for="name">Nom del sol·licitant</label>
                </div>
            </div>
            <div class="row">
                <div class="input-field col s6">
                    <i class="material-icons prefix">group_work</i>
                    <g:textField name="department" value="${department}" class="validate" required="required" />
                    <label for="department">Departament / servei</label>
                </div>
                <div class="input-field col s6">
                    <i class="material-icons prefix">domain</i>
                    <g:textField name="institution" value="${institution}" class="validate autocomplete" required="required" />
                    <label for="institution">Institució</label>
                </div>
            </div>
            <div class="row">
                <div class="input-field col s6">
                    <i class="material-icons prefix">phone</i>
                    <g:textField name="name" value="${name}" class="validate" required="required" />
                    <label for="name">Telèfon de contacte</label>
                </div>
                <div class="input-field col s6">
                    <i class="material-icons prefix">email</i>
                    <input type="email" name="email" id="email" class="validate" value="${email}" required="required" />
                    <label for="email" data-error="Escriu una adreça de correu vàlida" data-success="Adreça correcta">Correu electrònic</label>
                </div>
            </div>
            <div class="row">
                <div class="input-field col s6">
                    <i class="material-icons prefix">folder_open</i>
                    <g:textField name="researchProject" value="${researchProject}" class="validate" required="required" />
                    <label for="name">Projecte de recerca</label>
                </div>
                <div class="input-field col s6">
                    <i class="material-icons prefix">person_pin</i>
                    <g:textField name="primaryResearcher" value="${primaryResearcher}" class="validate" required="required" />
                    <label for="name">Investigador/a principal</label>
                </div>
            </div>
            <div class="row">
                <div class="col s6">
                    <input type="checkbox" id="isCREC" name="isCREC" />
                    <label for="isCREC">Compta amb l'aprovació del CEIC</label>
                </div>
                
            </div>
            <div class="row">
                <div class="col s12">
                    <h4><i class="material-icons prefix">blur_linear</i> Tipus d'estudi</h4>
                </div>
            </div>
            <div class="row">
                <div class="col s6">
                    <g:radio name="studyType" value="1" id="studyType1" required="required" />
                    <label for="studyType1">Amb finançament-Suport estadístic inclòs</label>
                </div>
            </div>
            <div class="row">
                <div class="col s6">
                    <g:radio name="studyType" value="2" class="mdl-radio__button" id="studyType2" />
                    <label for="studyType2">Amb finançament-Suport estadístic no inclòs</label>
                </div>
            </div>
            <div class="row">
                <div class="col s6">
                    <g:radio name="studyType" value="3" class="mdl-radio__button" id="studyType3" />
                    <label for="studyType3">Sense finançament</label>
                </div>
            </div>

            <div class="row">
                <div class="col s6">
                    <g:radio name="studyType" value="4" class="mdl-radio__button" id="studyType4" />
                    <label for="studyType4">Sol·licitud denou projecte</label>
                </div>
            </div>
            <div class="row">
                <div class="col s6">
                    <g:radio name="studyType" value="5" class="mdl-radio__button" id="studyType5" />
                    <label for="studyType5">Altres (especificar)</label>
                </div>
            </div>
            <div class="row">
                <div class="input-field col s6">
                    <g:textField name="otherStudyType" value="${otherStudyType}" class="validate" />
                    <label for="name">Altres tipus d'estudi</label>
                </div>
            </div>
            <div class="row">
                <div class="col s12">
                    <h4><i class="material-icons prefix">explore</i> Objectiu de l'estudi</h4>
                </div>
            </div>
            <div class="row">
                <div class="input-field col s12">
                    <textarea id="objective" class="materialize-textarea" data-length="500"></textarea>
                    <label for="objective">Especifiqueu quina pregunta pretén respondre l’estudi</label>
                </div>
            </div>
            <div class="row">
                <div class="col s12">
                    <h4><i class="material-icons prefix">playlist_add</i> Servei / Consulta</h4>
                </div>
            </div>
            <div class="row">
                <div class="col s12">
                    <g:checkBox name="isCompetitiveProject" />
                    <label for="isCompetitiveProject">Sol·licitud projecte competitiu</label>
                </div>
            </div>
            <div class="row">
                <div class="col s12">
                    <g:checkBox name="isStudyDesign" />
                    <label for="isStudyDesign">Disseny d’estudis</label>
                </div>
            </div>
            <div class="row">
                <div class="col s12">
                    <g:checkBox name="isPaperWriting" />
                    <label for="isPaperWriting">Redacció d’articles</label>
                </div>
            </div>
            <div class="row">
                <div class="col s12">
                    <g:checkBox name="isDatabaseDesign" />
                    <label for="isDatabaseDesign">Disseny de bases de dades</label>
                </div>
            </div>
            <div class="row">
                <div class="col s12">
                    <g:checkBox name="isDataAnalysis" />
                    <label for="isDataAnalysis">Anàlisi de dades</label>
                </div>
            </div>
            <div class="row">
                <div class="col s12">
                    <g:checkBox name="isOthers" />
                    <label for="isOthers">Altres: especificar</label>
                </div>
            </div>
            <div class="row">
                <div class="input-field col s12">
                    <g:textField name="others" value="${others}" class="validate" />
                    <label for="others">Altres: especificar</label>
                </div>
            </div>
            <div class="row">
                <div class="col s12">
                    <h4><i class="material-icons prefix">comment</i> Comentaris</h4>
                </div>
            </div>
            <div class="row">
                <div class="input-field col s12">
                    <textarea id="comments" class="materialize-textarea" data-length="500"></textarea>
                    <label for="comments">Altres comentaris</label>
                </div>
            </div>
            <button class="btn-large waves-effect waves-light" type="submit" name="action">Envia
                <i class="material-icons right">send</i>
            </button>
        </g:form>
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
                    <div class="carousel-item mrue white-text" href="#one!">
                        <h2><span class="yellow-text lighten-5">Dra.</span> Montserrat Rué</h2>
                        <p class="white-text">
                            <a class="white-text aligned" href="mailto:mrue@irblleida.cat">
                                <i class="material-icons">email</i> montse.rue@cmb.udl.cat
                            </a>
                        </p>
                        <p>ResearcherID: http://www.researcherid.com/rid/B-5663-2009</p>
                    </div>
                    <div class="carousel-item white-text" href="#two!">
                        <h2>Second Panel</h2>
                        <p class="white-text">This is your second panel</p>
                    </div>
                    <div class="carousel-item green white-text" href="#three!">
                        <h2>Third Panel</h2>
                        <p class="white-text">This is your third panel</p>
                    </div>
                    <div class="carousel-item blue white-text" href="#four!">
                        <h2>Fourth Panel</h2>
                        <p class="white-text">This is your fourth panel</p>
                    </div>
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
