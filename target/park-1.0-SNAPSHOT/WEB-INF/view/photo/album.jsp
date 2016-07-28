<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>

<t:wrapper title="Edit">

    <jsp:attribute name="body">
        <div class="container" style="margin-top: 50px">
            <label>Album</label>
            <label><input type="text" class="form-control" name="album" style="margin-left: 10px"
                          placeholder="Album name" id="albumName" value="${albumDto.getName()}" /></label>
            <button class="btn btn-default btnSave" style="margin-left: 10px">Save</button>
            <button type="button" class="btn btn-success" style="margin-left: 10px" id="start-slideshow">Strat SlideShow</button>

            <div class="mblock">
                <div class="row" id="settings">
                    <div class="col-md-3">
                        <div class="checkbox">
                            <label>
                                Speed
                                <input type="range" value="-7000" min="-10000" max="-200" step="100" id="speed">
                            </label>
                        </div>
                        <div class="checkbox">
                            <label>
                                Speed of effects
                                <input type="range" value="-1500" min="-3000" max="-100" step="100" id="effect-speed">
                            </label>
                        </div>
                        <div class="checkbox">
                            <label class="switch">
                                <input type="checkbox" id="randomOrder" class="a">
                            </label>
                            Random order
                        </div>
                    </div>
                    <div class="col-md-3 effects">
                        <div class="checkbox">
                            <label class="switch">
                                <input type="checkbox" id="simpleFade" class="a">
                            </label>
                            Simple fade
                        </div>
                        <div class="checkbox">
                            <label class="switch">
                                <input type="checkbox" id="curtainTopLeft" class="a">
                            </label>
                            Curtain top-left
                        </div>
                        <div class="checkbox">
                            <label class="switch">
                                <input type="checkbox" id="curtainTopRight" class="a">
                            </label>
                            Curtain top-right
                        </div>
                        <div class="checkbox">
                            <label class="switch">
                                <input type="checkbox" id="curtainBottomLeft" class="a">
                            </label>
                            Curtain bottom-left
                        </div>
                        <div class="checkbox">
                            <label class="switch">
                                <input type="checkbox" id="curtainBottomRight" class="a">
                            </label>
                            Curtain bottom-right
                        </div>
                    </div>
                    <div class="col-md-3 effects">
                        <div class="checkbox">
                            <label class="switch">
                                <input type="checkbox" id="curtainSliceLeft" class="a">
                            </label>
                            Curtain slice left
                        </div>
                        <div class="checkbox">
                            <label class="switch">
                                <input type="checkbox" id="curtainSliceRight" class="a">
                            </label>
                            Curtain slice right
                        </div>
                        <div class="checkbox">
                            <label class="switch">
                                <input type="checkbox" id="mosaic" class="a">
                            </label>
                            Mosaic
                        </div>
                        <div class="checkbox">
                            <label class="switch">
                                <input type="checkbox" id="mosaicSpiral" class="a">
                            </label>
                            Spiral mosaic
                        </div>
                    </div>
                </div>
            </div>

            <div class="container" style="margin-top: 10px">
            <div class="row connectedSortable" id="sortable1" style="min-height: 250px; border: 5px solid gray;">
            <c:forEach items="${albumDto.getPhotos()}" var="photo">
                <div class="col-md-3" id="${photo.getUrl()}">
                <div class="thumbnail">
                    <img src="${photo.getUrl()}"/>">
                </div>
                </div>
            </c:forEach>
            </div>
        </div>
        </div>

                <div class="container" style="margin-top: 50px">
                    <label>Images</label>
                    <div class="row connectedSortable" id="sortable2" style="margin-left: 10px; min-height: 250px; border: 5px solid gray;">
        <c:forEach items="${list}" var="i">
            <div class="col-md-3" id="${i}">
                <div class="thumbnail" id="${i}">
                    <img src=${i}>
                </div>
            </div>
        </c:forEach>
                    </div>
                </div>
    </jsp:attribute>

    <jsp:attribute name="scripts">
	<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
	<script src="https://code.jquery.com/ui/1.12.0/jquery-ui.js"></script>
    <link rel="stylesheet" href="/resources/css/jquery-ui.structure.min.css" />
    <link rel="stylesheet" href="/resources/css/jquery-ui.theme.min.css" />
    <link rel="stylesheet" href="/resources/css/jquery-ui.min.css" />


        <script>

    var savedSorting = [];
            function saveSorting() {
                $(this).toArray().forEach(function (item, i) {
                    if(item.id == 'sortable1'){
                        savedSorting = [];
                        Array.prototype.slice.call(item.childNodes).forEach(function (item) {
                            if(item.className = 'col-md-3') {savedSorting.push(item.id)}
                        });
                        savedSorting.shift();
                    }
                });
            }

            $(function() {
                $( "#sortable1, #sortable2" ).sortable({
                    connectWith: ['.connectedSortable'],
                    placeholder: "ui-sortable-placeholder",
                    update: saveSorting
                });
            });

            var slideShowClicked = false;

            $('.btnSave').on('click', function () {
                var albumName = document.getElementById('albumName').value;
                if(!albumName) albumName = 'New album';
                var effects = "";
                $('.effects').find('input:checked').each(function () {
                    effects += $(this).attr('id') + ', ';
                });
                if (effects.length != 0) {effects = effects.slice(0, -2);}
                if (effects.length === 0) {
                    effects = "random";
                }
                console.log(savedSorting);
                console.log(albumName);
                console.log(effects);
                var speed = $('#speed').val() * -1;
                console.log(speed);
                var effectSpeed = $('#effect-speed').val() * -1;
                console.log(effectSpeed);
                var randomOrder = $('#randomOrder').prop('checked');
                console.log(randomOrder);
                console.log(${newAlbum.getId()});
                if(savedSorting) savedSorting = savedSorting.join('$_');
                console.log(savedSorting);

                $.post('saveAlbum', {
                    savedSorting: savedSorting,
                    name: albumName,
                    effects: effects,
                    speed: speed,
                    effectSpeed: effectSpeed,
                    randomOrder: randomOrder,
                    id: ${newAlbum.getId()},
                    "${_csrf.parameterName}": "${_csrf.token}"}, function(data, status) {
                    if(slideShowClicked){
                        slideShowClicked = false;
                        window.location.href = '/slideShow/${newAlbum.getId()}';
                    } else window.location.reload(true);
                })
            });


            $('#start-slideshow').on('click', function () {
                slideShowClicked = true;
                $('.btnSave').click();
            });
        </script>

        <script>
//            $(document).ready(function () {
                <%--<c:forEach items="${albumDto.effects}" var="effect">--%>
                <%--$('#${effect}').prop('checked', true);--%>
                <%--</c:forEach>--%>
                <%--var speed = $('#speed').val((-1) * ${albumDto.speed});--%>
                <%--var effectSpeed = $('#effect-speed').val((-1) * ${albumDto.effectsSpeed});--%>
                <%--var randomOrder = $('#randomOrder').prop('checked', ${albumDto.random});--%>
                <%--$('#all-photos, #album-photos').sortable({--%>
                    <%--cursor: "move",--%>
                    <%--connectWith: ".flex-container"--%>
                <%--});--%>
//                $('.form-inline').submit(function () {
//                    var photoIds = [];
//                    $('#album-photos').children().each(function () {
//                        photoIds.push($(this).data('photoid'));
//                    });
//                    if (photoIds.length === 0) {
//                        photoIds.push("nope");
//                    }
//                    console.log(photoIds);
//                    var effects = "";
//                    $('.effects').find('input:checked').each(function () {
//                        effects += $(this).attr('id') + '$';
//                    });
//                    if (effects.length === 0) {
//                        effects = "random";
//                    }
//                    var speed = $('#speed').val() * -1;
//                    var effectSpeed = $('#effect-speed').val() * -1;
//                    var randomOrder = $('#randomOrder').prop('checked');
//                    console.log(randomOrder);
//                    console.log(effects, speed, effectSpeed);
                    <%--$.post('add', {album_name: $('#album-name').val(),--%>
                        <%--photo_list: photoIds,--%>
                        <%--id: ${albumDto.id},--%>
                        <%--random: randomOrder,--%>
                        <%--speed: speed,--%>
                        <%--effect_speed: effectSpeed,--%>
                        <%--effects: effects,--%>
                    <%--${_csrf.parameterName}: "${_csrf.token}"});--%>
                <%--&lt;%&ndash;});&ndash;%&gt;--%>
                <%--$('#start-slideshow').on('click', function () {--%>
                    <%--$('.btnSave').click();--%>
                    <%--var photoUrls = [];--%>
                    <%--$('#album-photos').children().each(function () {--%>
                        <%--photoIds.push($(this).data('photoid'));--%>
                    <%--});--%>
                    <%--if (photoIds.length === 0) {--%>
                        <%--photoIds.push("nope");--%>
                    <%--}--%>
                    <%--var effects = "";--%>
                    <%--$('.effects').find('input:checked').each(function () {--%>
                        <%--effects += $(this).attr('id') + '$';--%>
                    <%--});--%>
                    <%--if (effects.length === 0) {--%>
                        <%--effects = "random";--%>
                    <%--}--%>
                    <%--var speed = $('#speed').val() * -1;--%>
                    <%--var effectSpeed = $('#effect-speed').val() * -1;--%>
                    <%--var randomOrder = $('#randomOrder').prop('checked');--%>
                    <%--console.log(randomOrder);--%>
                    <%--console.log(effects, speed, effectSpeed);--%>
                    <%--$.post('saveAlbum', {album_name: $('#albumName').val(),--%>
                        <%--photo_list: photoIds,--%>
                        <%--id: ${albumDto.id},--%>
                        <%--random: randomOrder,--%>
                        <%--speed: speed,--%>
                        <%--effect_speed: effectSpeed,--%>
                        <%--effects: effects,--%>
                    <%--${_csrf.parameterName}: "${_csrf.token}"}, function () {--%>
                        <%--if (photoIds[0] !== 'nope') {--%>
                            <%--window.location.href = '/albums/show/${albumDto.id}';--%>
                        <%--} else {--%>
                            <%--$('#album-photos').css('border', '1px solid rgba(202, 47, 22, 0.75)');--%>
                        <%--}--%>
                    <%--});--%>
                <%--});--%>
//            });
        </script>

    </jsp:attribute>

</t:wrapper>