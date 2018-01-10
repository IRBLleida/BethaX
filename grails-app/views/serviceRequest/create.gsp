<%@ page import="org.irblleida.bethax.User" %>
<!DOCTYPE html>
<html>
<head>
    <title>UBiostat - Nova petició de servei / consulta</title>
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.100.2/css/materialize.min.css">
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <style>
        .aligned {
            display: inline-flex;
            vertical-align: middle;
        }

        .aligned > .material-icons {
            margin-right: 10px;
        }

        *,
        *:after,
        *:before {
            -webkit-box-sizing: border-box;
            box-sizing: border-box;
        }

        html {
            -webkit-font-smoothing: antialiased;
            -moz-osx-font-smoothing: grayscale;
            text-rendering: optimizelegibility;
        }

        ul li {
            list-style-type: none;
        }

        .slider--teams {
            margin-top: 100px;
            position: relative;
            top: 50%;
            left: 50%;
            max-width: 750px;
            opacity: 0;
            -webkit-transform: translate(-50%, -50%);
            transform: translate(-50%, -50%);
        }
        .slider--teams .slider--teams__team {
            position: relative;
            overflow: hidden;
        }

        #list {
            position: relative;
            -webkit-backface-visibility: hidden;
            backface-visibility: hidden;
            -webkit-transform: translate3d(0, 0, 0);
            transform: translate3d(0, 0, 0);
        }
        #list li {
            position: relative;
            display: inline-block;
            float: left;
            text-align: center;
        }
        #list li figure {
            cursor: pointer;
            margin: 1em;
            opacity: 0.5;
            -webkit-backface-visibility: hidden;
            backface-visibility: hidden;
            -webkit-transition: opacity 450ms ease-in-out, -webkit-transform 450ms cubic-bezier(0.445, 0.05, 0.55, 0.95);
            transition: opacity 450ms ease-in-out, -webkit-transform 450ms cubic-bezier(0.445, 0.05, 0.55, 0.95);
            transition: transform 450ms cubic-bezier(0.445, 0.05, 0.55, 0.95), opacity 450ms ease-in-out;
            transition: transform 450ms cubic-bezier(0.445, 0.05, 0.55, 0.95), opacity 450ms ease-in-out, -webkit-transform 450ms cubic-bezier(0.445, 0.05, 0.55, 0.95);
            -webkit-transform: scale(0.5) translateZ(0px);
            transform: scale(0.5) translateZ(0px);
        }
        #list li figure:hover {
            opacity: 0.8;
            -webkit-transform: scale(0.6) translateZ(0px);
            transform: scale(0.6) translateZ(0px);
        }
        #list li figure:active {
            opacity: 1;
            -webkit-transform: scale(0.7) translateZ(0px);
            transform: scale(0.7) translateZ(0px);
        }
        #list li figure > div {
            border-radius: 5px;
            position: relative;
            margin: 2rem auto;
            width: 120px;
            height: 120px;
            overflow: hidden;
            -webkit-transform: rotate(45deg) translateZ(0px);
            transform: rotate(45deg) translateZ(0px);
        }
        #list li figure > div > div {
            /*background: url(https://s3-us-west-2.amazonaws.com/s.cdpn.io/953/teams.jpg) no-repeat;*/
            background-size: cover;
            background-position: 0px 0px;
            position: absolute;
            top: 50%;
            left: 50%;
            width: 170px;
            height: 170px;
            -webkit-transform: rotate(-45deg) translate(0%, -70%);
            transform: rotate(-45deg) translate(0%, -70%);
        }
        #list li figure figcaption h2 {
            color: #333;
            font-size: 1.6rem;
            font-weight: 800;
        }
        #list li figure figcaption p {
            color: #666;
            font-size: 0.9rem;
            font-weight: 400;
        }
        #list li:nth-child(1) figure > div > div {
            background-position: 0px 0px !important;
        }
        #list li:nth-child(2) figure > div > div {
            background-position: 0px 20% !important;
        }
        #list li:nth-child(3) figure > div > div {
            background-position: 0px 40% !important;
        }
        #list li:nth-child(4) figure > div > div {
            background-position: 0px 60% !important;
        }
        #list li:nth-child(5) figure > div > div {
            background-position: 0px 80% !important;
        }
        #list li:nth-child(6) figure > div > div {
            background-position: 0px 100% !important;
        }

        .active {
            opacity: 1 !important;
            -webkit-transform: scale(1) translateZ(0px) !important;
            transform: scale(1) translateZ(0px) !important;
        }

        .cf:before,
        .cf:after {
            content: " ";
            display: table;
        }

        .cf:after {
            clear: both;
        }

        .cf {
            *zoom: 1;
        }
    </style>
</head>
<body>
<nav class="light-blue lighten-1" role="navigation">
    <div class="nav-wrapper container"><a id="logo-container" href="#" class="brand-logo">UBiostat</a>
        <ul class="right hide-on-med-and-down">
            <li><a href="http://www.irblleida.org" target="_blank">IRBLleida</a></li>
        </ul>

        <ul id="nav-mobile" class="side-nav">
            <li><a href="http://www.irblleida.org" target="_blank">IRBLleida</a></li>
        </ul>
        <a href="#" data-activates="nav-mobile" class="button-collapse"><i class="material-icons">menu</i></a>
    </div>
</nav>
<div class="section no-pad-bot" id="index-banner">
    <div class="container">
        <g:hasErrors bean="${this.project}">
            <div class="alert alert-warning" role="alert">
                <g:eachError bean="${this.project}" var="error">
                    <p <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></p>
                </g:eachError>
            </div>
        </g:hasErrors>
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
                    <g:textField name="phone" value="${phone}" class="validate" required="required" />
                    <label for="phone">Telèfon de contacte</label>
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
                    <g:radio name="studyType" value="FUNDED_WITH_SUPPORT" id="studyType1" required="required" />
                    <label for="studyType1">Amb finançament-Suport estadístic inclòs</label>
                </div>
            </div>
            <div class="row">
                <div class="col s6">
                    <g:radio name="studyType" value="FUNDED_WITHOUT_SUPPORT" class="mdl-radio__button" id="studyType2" />
                    <label for="studyType2">Amb finançament-Suport estadístic no inclòs</label>
                </div>
            </div>
            <div class="row">
                <div class="col s6">
                    <g:radio name="studyType" value="NOT_FUNDED" class="mdl-radio__button" id="studyType3" />
                    <label for="studyType3">Sense finançament</label>
                </div>
            </div>

            <div class="row">
                <div class="col s6">
                    <g:radio name="studyType" value="NEW_PROJECT" class="mdl-radio__button" id="studyType4" />
                    <label for="studyType4">Sol·licitud de nou projecte</label>
                </div>
            </div>
            <div class="row">
                <div class="col s6">
                    <g:radio name="studyType" value="OTHERS" class="mdl-radio__button" id="studyType5" />
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
                    <textarea id="studyObjective" name="studyObjective" class="materialize-textarea" data-length="500"></textarea>
                    <label for="studyObjective">Especifiqueu quina pregunta pretén respondre l’estudi</label>
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
                    <textarea id="comments" name="comments" class="materialize-textarea" data-length="500"></textarea>
                    <label for="comments">Altres comentaris</label>
                </div>
            </div>
            <button class="btn-large waves-effect waves-light pulse" type="submit" name="action">Envia
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
                <div class="slider--teams">
                    <div class="slider--teams__team">
                        <ul id="list" class="cf">
                            <g:each var="user" in="${org.irblleida.bethax.User.list()}">
                                <li>
                                    <figure>
                                        <div>
                                            <div>
                                                <img src="${createLink(controller: "user", action: "photo", id: user.id.toString())}" width="100%" />
                                            </div>
                                        </div>
                                        <figcaption>
                                            <h2>${user}</h2>
                                            <g:if test="${user.position}">
                                                <p>${user.position}</p>
                                            </g:if>
                                        </figcaption>
                                    </figure>
                                </li>
                            </g:each>
                        </ul>
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
<script src="https://cdnjs.cloudflare.com/ajax/libs/velocity/1.1.0/velocity.min.js"></script>
<script>
    var sliderTeam = (function(document, $) {
        var $sliderTeams = $('.slider--teams'),
            $list = $('#list'),
            $listItems = $('#list li'),
            $nItems = $listItems.length,
            $nView = 3,
            autoSlider,
            $current = 0,
            $isAuto = true,
            $acAuto = 2500,

            _init = function() {
                _initWidth();
                _eventInit();
            },

            _initWidth = function() {
                $list.css({
                    'margin-left': Math.floor(100 / $nView) + '%',
                    'width': Math.floor(100 * ($nItems / $nView)) + '%'
                });
                $listItems.css('width', 100 / $nItems + '%');
                $sliderTeams.velocity({ opacity: 1 }, { display: "block" }, { delay:1000 });
            },

            _eventInit = function() {

                window.requestAnimFrame = (function() {
                    return  window.requestAnimationFrame       ||
                        window.webkitRequestAnimationFrame ||
                        window.mozRequestAnimationFrame    ||
                        window.oRequestAnimationFrame      ||
                        window.msRequestAnimationFrame     ||
                        function(callback, element){
                            window.setTimeout(callback, 1000 / 60);
                        };
                })();

                window.requestInterval = function(fn, delay) {
                    if( !window.requestAnimationFrame       &&
                        !window.webkitRequestAnimationFrame &&
                        !window.mozRequestAnimationFrame    &&
                        !window.oRequestAnimationFrame      &&
                        !window.msRequestAnimationFrame)
                        return window.setInterval(fn, delay);
                    var start = new Date().getTime(),
                        handle = new Object();

                    function loop() {
                        var current = new Date().getTime(),
                            delta = current - start;
                        if(delta >= delay) {
                            fn.call();
                            start = new Date().getTime();
                        }
                        handle.value = requestAnimFrame(loop);
                    };
                    handle.value = requestAnimFrame(loop);
                    return handle;
                }

                window.clearRequestInterval = function(handle) {
                    window.cancelAnimationFrame ? window.cancelAnimationFrame(handle.value) :
                        window.webkitCancelRequestAnimationFrame ? window.webkitCancelRequestAnimationFrame(handle.value)   :
                            window.mozCancelRequestAnimationFrame ? window.mozCancelRequestAnimationFrame(handle.value) :
                                window.oCancelRequestAnimationFrame ? window.oCancelRequestAnimationFrame(handle.value) :
                                    window.msCancelRequestAnimationFrame ? msCancelRequestAnimationFrame(handle.value) :
                                        clearInterval(handle);
                };

                $.each($listItems, function(i) {
                    var $this = $(this);
                    $this.on('touchstart click', function(e) {
                        e.preventDefault();
                        _stopMove(i);
                        _moveIt($this, i);
                    });
                });

                autoSlider = requestInterval(_autoMove, $acAuto);
            },

            _moveIt = function(obj, x) {

                var n = x;

                obj.find('figure').addClass('active');
                $listItems.not(obj).find('figure').removeClass('active');

                $list.velocity({
                    translateX: Math.floor((-(100 / $nItems)) * n) + '%',
                    translateZ: 0
                }, {
                    duration: 2000,
                    easing: [400, 26],
                    queue: false
                });

            },

            _autoMove = function(currentSlide) {
                if ($isAuto) {
                    $current = ~~(($current + 1) % $nItems);
                } else {
                    $current = currentSlide;
                }
                console.log($current);
                _moveIt($listItems.eq($current), $current);
            },

            _stopMove = function(x) {
                clearRequestInterval(autoSlider);
                $isAuto = false;
                _autoMove(x);
            };

        return {
            init: _init
        };

    })(document, jQuery);


    $(document).ready(function(){
        sliderTeam.init();
    });
</script>
</body>
</html>
