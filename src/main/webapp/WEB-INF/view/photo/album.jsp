<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>

<t:wrapper title="Edit">

    <jsp:attribute name="body">
        <div class="container" style="margin-top: 50px">
            <label>Альбом</label>
            <div class="row connectedSortable" id="sortable1" style="min-height: 250px; border: 5px solid gray;"></div>
            <button class="btn btn-default" style="float: right; margin-top: 10px">Save</button>
        </div>

        <div class="container" style="margin-top: 50px">
            <div class="row connectedSortable" id="sortable2">
        <c:forEach items="${list}" var="i">
            <div class="col-md-3" id="${i}">
                <div class="thumbnail">
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
var savedSorting;
            function saveSorting() {
                $(this).toArray().forEach(function (item, i) {
                    if(item.id == 'sortable1'){
                        savedSorting = [];
                        Array.prototype.slice.call(item.childNodes).forEach(function (item) {
                            savedSorting.push(item.id);
                        });
//                        savedSorting.forEach(function (item) {
//                            console.log(item)
//                        });
                    }
                });
                return $(this).sortable('serialize').replace(/\[]=/g, '_');
            }

            $(function() {
                $( "#sortable1, #sortable2" ).sortable({
                    connectWith: ['.connectedSortable'],
                    placeholder: "ui-sortable-placeholder",
                    update: saveSorting
                });
            });

        </script>

        <script>
            $('.btn').on('click', function () {
                $.post('/saveAlbum', {'savedSorting': savedSorting})
            })
        </script>

    </jsp:attribute>

</t:wrapper>