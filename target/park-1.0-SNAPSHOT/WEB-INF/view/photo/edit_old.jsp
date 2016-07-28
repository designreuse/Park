<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>

<t:wrapper title="Edit">
    <jsp:attribute name="body">
      <div class="row">
          <div class="col-md-9">
              <canvas id="main-canvas" width="800" height="600" style="border: 1px solid rgb(0, 0, 0); margin: 20px; "></canvas>
          </div>
          <div class="col-md-3">
              <form style="margin-top: 50px;">
                  <div class="checkbox">
                      <label>
                          Яркость
                          <input type="range" value="0" min="0" max="100" step="2" class="slider" id="slider-brightness">
                      </label>
                  </div>
                  <div class="checkbox">
                      <label>
                          Пиксельность
                          <input type="range" value="1" min="1" max="25" step="1" class="slider" id="slider-pixel">
                      </label>
                  </div>
                  <div class="checkbox">
                      <label>
                          Градиент
                          <input type="range" value="1" min="0" max="254"  step="5" class="slider" id="slider-gradient">
                      </label>
                  </div>
                  <div class="checkbox">
                      <label>
                          Шум
                          <input type="range" value="0" min="0" max="1000" step="20" class="slider" id="slider-noise">
                      </label>
                  </div>

                  <div class="checkbox">
                      <label>
                          Красный
                          <input type="range" value="255" min="0" max="255" step="2" class="slider" id="slider-red">
                      </label>
                  </div>
                  <div class="checkbox">
                      <label>
                          Зеленый
                          <input type="range" value="255" min="0" max="255" step="2" class="slider" id="slider-green">
                      </label>
                  </div>
                  <div class="checkbox">
                      <label>
                          Синий
                          <input type="range" value="255" min="0" max="255" step="2" class="slider" id="slider-blue">
                      </label>
                  </div>

                  <div class="checkbox">
                      <label>
                          <input type="checkbox" class="filter-box" id="filter-sepia"> Сепия
                      </label>
                  </div>
                  <div class="checkbox">
                      <label>
                          <input type="checkbox" class="filter-box" id="filter-grayscale"> Черно-белое
                      </label>
                  </div>
                  <div class="checkbox">
                      <label>
                          <input type="checkbox" class="filter-box" id="filter-inversion"> Инверсия
                      </label>
                  </div>
                  <div class="checkbox">
                      <label>
                          <input type="checkbox" class="filter-box" id="filter-sepia2"> Сепия
                      </label>
                  </div>
                  <div class="checkbox">
                      <label>
                          <input type="checkbox" class="filter-box" id="filter-blur"> Блюр
                      </label>
                  </div>
                  <div class="checkbox">
                      <label>
                          <input type="checkbox" class="filter-box" id="filter-sharpen"> Резко
                      </label>
                  </div>
                  <div class="checkbox">
                      <label>
                          <input type="checkbox" class="filter-box" id="filter-emboss"> Чеканка
                      </label>
                  </div>
                  <button type="submit" class="btn btn-primary">Сохранить</button>
              </form>
          </div>
      </div>
    </jsp:attribute>
    <jsp:attribute name="scripts">
    <script src="/resources/js/jquery.js" type="text/javascript"></script>
    <script src="/resources/js/fabric.min.js" type="text/javascript"></script>
        <script type="text/javascript">
            var canvas = new fabric.Canvas('main-canvas');
            canvas.selection = true;

            var mainImage;

            fabric.Image.fromURL('https://pbs.twimg.com/profile_images/660946436801101824/niM7azZS.jpg', function(image) {
                mainImage = image;
                canvas.add(mainImage);
            }, {crossOrigin: 'anonymous'});

            // sliders
            $('.slider').on("input", (function(e){
                var filterType;
                var filter;
                var id = e.target.id;
                if (id == 'slider-brightness') {
                    filterType = fabric.Image.filters.Brightness;
                    filter = new filterType({
                        brightness: $(this).val() * 2.55
                    });
                } else if (id == 'slider-pixel') {
                    filterType = fabric.Image.filters.Pixelate;
                    filter = new filterType({
                        blocksize: $(this).val() * 1
                    });
                }
                else if (id == 'slider-gradient') {
                    filterType = fabric.Image.filters.GradientTransparency;
                    filter = new filterType({
                        threshold: 255 - $(this).val()
                    });
                }
                else if (id == 'slider-noise') {
                    filterType = fabric.Image.filters.Noise;
                    filter = new filterType({
                        noise: $(this).val() * 1
                    });
                }
                else if (id == 'slider-red' || id == 'slider-green' || id == 'slider-blue') {
                    filterType = fabric.Image.filters.Multiply;
                    filter = new filterType({
                        color: 'rgb(' + $('#slider-red').val() + ', ' + $('#slider-green').val() + ', ' + $('#slider-blue').val() +')'
                    });
                }
                for (var i = mainImage.filters.length - 1; i >= 0; i--) {
                    if (mainImage.filters[i] instanceof filterType) {
                        mainImage.filters.splice(i, 1);
                        break;
                    }
                }
                mainImage.filters.push(filter);
                mainImage.applyFilters(canvas.renderAll.bind(canvas));
            }));

            // checkboxes
            $('.filter-box').click(function (e) {
                var filterType;
                var filter;
                var id = e.target.id;
                if (id == 'filter-sepia') {
                    filterType = fabric.Image.filters.Sepia;
                } else if (id == 'filter-grayscale') {
                    filterType = fabric.Image.filters.Grayscale;
                }
                else if (id == 'filter-inversion') {
                    filterType = fabric.Image.filters.Invert;
                }
                else if (id == 'filter-sepia2') {
                    filterType = fabric.Image.filters.Sepia2;
                }
                else if (id == 'filter-sharpen') {
                    filterType = fabric.Image.filters.Convolute;
                    filter = new filterType({
                        matrix: [ 0, -1,  0,
                            -1,  5, -1,
                            0, -1,  0 ]
                    });
                }
                else if (id == 'filter-emboss') {
                    filterType = fabric.Image.filters.Convolute;
                    filter = new filterType({
                        matrix: [ 1,   1,  1,
                            1, 0.7, -1,
                            -1,  -1, -1 ]
                    });
                }
                else if (id == 'filter-blur') {
                    filterType = fabric.Image.filters.Convolute;
                    filter = new filterType({
                        matrix: [ 1/9, 1/9, 1/9,
                            1/9, 1/9, 1/9,
                            1/9, 1/9, 1/9 ]
                    });
                }
                filter = filter || new filterType();
                if ($(this).is(':checked')) {
                    mainImage.filters.push(filter);
                    mainImage.applyFilters(canvas.renderAll.bind(canvas));
                } else {
                    for (var i = mainImage.filters.length - 1; i >= 0; i--) {
                        if (mainImage.filters[i] instanceof filterType) {
                            mainImage.filters.splice(i, 1);
                            break;
                        }
                    }
                    mainImage.applyFilters(canvas.renderAll.bind(canvas));
                }
            });

            function download(url,name){
                // make the link. set the href and download. emulate dom click
                $('<a>').attr({href:url,download:name})[0].click();
            }
            $('form:first').submit(function() {
                canvas.deactivateAll().renderAll();
                download(canvas.toDataURL(), 'dddd.png');
                return false;
            });


            //canvas.renderAll();
        </script>
    </jsp:attribute>
</t:wrapper>