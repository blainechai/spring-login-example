<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<% request.setCharacterEncoding("utf-8"); %>
<% response.setCharacterEncoding("utf-8"); %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta charset="utf-8">
    <title>REMOS</title>
    <script src="/js/jquery.min.js"></script>
    <!-- 합쳐지고 최소화된 최신 CSS -->
    <link rel="stylesheet"
          href="/css/bootstrap.min.css">
    <!-- 부가적인 테마 -->

    <!-- 합쳐지고 최소화된 최신 자바스크립트 -->
    <script src="/js/bootstrap.min.js"></script>
    <style type="text/css">
        svg {
            background-color: #fff;
            border-radius: 4px;
            /*fill: gray;*/
        }

        svg g path.line {
            stroke-width: 2px;
            stroke-opacity: 0.5;
            fill: none;
        }

        svg g path.line.total {
            stroke-dasharray: 3;
            stroke-width: 2px;
            stroke-opacity: 0.7;
            fill: none;
        }

        svg g circle {
            fill: #1db34f;
            stroke: #16873c;
            stroke-width: 2px;
        }

        .axis path,
        .axis line {
            fill: none;
            stroke: grey;
            stroke-width: 1;
            shape-rendering: crispEdges;
        }

        .y.axis text {
            font-size: 10px;
        }

        .x.axis text {
            font-size: 10px;
        }
    </style>

    <!-- Latest compiled and minified CSS -->

    <%--<link rel="stylesheet"--%>
    <%--href="//cdnjs.cloudflare.com/ajax/libs/bootstrap-table/1.11.0/bootstrap-table.min.css">--%>

    <link href="/css/main-style.css" rel="stylesheet" type="text/css">
    <link href="/css/bootstrap-datetimepicker.min.css" rel="stylesheet" type="text/css">
    <%--<link href="/css/bootstrap-select.css" rel="stylesheet" type="text/css">--%>


    <!-- Latest compiled and minified JavaScript -->
    <%--<script--%>
    <%--src="//cdnjs.cloudflare.com/ajax/libs/bootstrap-table/1.11.0/bootstrap-table.min.js"></script>--%>

    <!-- Latest compiled and minified Locales -->

    <script src="/js/colResizable-1.6.js"></script>
    <script src="/js/moment.js"></script>
    <%--<script src="/js/transition.js"></script>--%>
    <script src="/js/bootstrap-datetimepicker.js"></script>
    <%--<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>--%>
    <script src="/js/jquery-ui.js"></script>
    <script src="/js/FileSaver.js"></script>
    <script src="/js/Blob.js"></script>
    <script src="/js/d3.v3.min.js"></script>
    <script src="/js/randomColor.js"></script>
    <script src="/js/line-graph.js"></script>
    <script src="/js/bookmark-table.js"></script>
</head>
<body>
<div id="header-wrapper">
    <h1>Real-TimeMonitoring System(REMOS)</h1>
</div>
<div id="nav-wrapper">
    <div id="nav"><a href="#">
        <div class="header-button btn active">
            <div class="glyphicon glyphicon-bell"></div>
            <div>알림</div>
        </div>
    </a>
        <a href="/main/status">
            <div class="header-button btn">
                <div class="glyphicon glyphicon-off"
                     style="text-align: center; font-size: 27px; padding-top: 10px;"></div>
                <div>시스템 상태</div>
            </div>
        </a>
        <a href="/main/profile">
            <div class="header-button btn">
                <div class="glyphicon glyphicon-list-alt"
                     style="text-align: center; font-size: 27px; padding-top: 10px;"></div>
                <div>프로파일링</div>
            </div>
        </a>
        <a href="/main/statistics">
            <div class="header-button btn">
                <div class="glyphicon glyphicon-signal"
                     style="text-align: center; font-size: 27px; padding-top: 10px;"></div>
                <div>통계</div>
            </div>
        </a>
        <a href="/main/search">
            <div class="header-button btn ">
                <div class="glyphicon glyphicon-search"
                     style="text-align: center; font-size: 27px; padding-top: 10px;"></div>
                <div>검색</div>
            </div>
        </a>
    </div>
</div>

<div id="content" class="" style="">
    <div id="content-wrapper" style="height: 100%;">
        <div id="alarm-table-group" class="col-xs-5" style="height: 100%; background: #efefef;">
            <div id="alarm-admin-bookmark" class="panel panel-default"
                 style="height: calc(50% - 25px); padding: 15px;margin-top:15px;">
            </div>
            <div id="alarm-user-bookmark" class="panel panel-default" style="height: calc(50% - 25px); padding: 15px;">
            </div>
        </div>
        <div class="col-xs-7"
             style="width:calc(58.33333333% - 15px);  height: 100%;background: rgba(224, 234, 244, 1); margin-left: 15px; ">
            <div id="alarm-content-result" class="panel panel-default"
                 style="height: calc(100% - 30px); margin-bottom: 0;margin-top:15px;">
                <div id="relative-table-container" style="position: absolute; z-index: 10;"></div>
                <div id="menu-wrapper" style="background: rgba(224, 234, 244, 1);">
                    <div class="alert alert-info">
                        <div id="search-result-number">검색결과 :
                        </div>
                        <div id="search-progress" class="progress">
                            <div class="progress-bar progress-bar-striped active" role="progressbar" aria-valuenow="45"
                                 aria-valuemin="0" aria-valuemax="100" style="width: 45%;">
                                45%
                            </div>
                        </div>
                    </div>
                    <div id="result-table-wrapper" class="panel panel-default"
                         style="margin: 15px; overflow: auto; height: calc(100% - 200px); font-size: 11px">
                        <div style="background: #ffffff;">
                            <table id="book-table-header"
                                   class="table table-fixed table-bordered table-striped JColResizer JCLRFlex table-condensed"
                                   style="position: absolute; top: 0; background: #ffffff; z-index: 4;">
                                <thead id="header" style="">
                                <tr>
                                    <th>번호</th>
                                    <th>우선순위</th>
                                    <th>그룹</th>
                                    <th>발행일자</th>
                                    <th>저장일자</th>
                                    <th>저자</th>
                                    <th>참조저자</th>
                                    <th>R</th>
                                    <th>E</th>
                                    <th>내용</th>
                                    <th>비고1</th>
                                    <th>비고2</th>
                                </tr>
                                </thead>
                            </table>
                        </div>
                        <div>
                            <table id="book-table"
                                   class="table table-hover table-fixed table-bordered table-striped table-condensed"
                                   style="height: 100%;">
                                <thead>
                                <tr style="">
                                    <th>번호</th>
                                    <th>우선순위</th>
                                    <th>그룹</th>
                                    <th>발행일자</th>
                                    <th>저장일자</th>
                                    <th>저자</th>
                                    <th>참조저자</th>
                                    <th>R</th>
                                    <th>E</th>
                                    <th>내용</th>
                                    <th>비고1</th>
                                    <th>비고2</th>
                                </tr>
                                </thead>
                                <tbody>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <div id="page-counter-wrapper">
                        <nav aria-label="..." style="text-align: center;">
                            <ul class="pagination pagination-sm" style="margin: 0 auto;">
                                <li class="disabled"><a href="#" aria-label="Previous"><span
                                        aria-hidden="true">«</span></a></li>
                                <li class="active"><a href="#">1</a></li>
                                <li><a href="#">2</a></li>
                                <li><a href="#">3</a></li>
                                <li><a href="#">4</a></li>
                                <li><a href="#">5</a></li>
                                <li><a href="#" aria-label="Next"><span
                                        aria-hidden="true">»</span></a></li>
                            </ul>
                        </nav>
                        <div>하이라이팅<input id="highlight-checkbox" type="checkbox"></div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript" charset="UTF-8">
    var relStartPos = new Object();
    relStartPos.left = 100;
    relStartPos.top = 200;
    relStartPos.iLeft = 100;
    relStartPos.iTop = 200;
    relStartPos.maxLeft = 300;
    relStartPos.maxTop = 300;
    relStartPos.count = 0;
    var tableData;
    var lastQuery;

    var userBookmarkModule = BookmarkTableModule.getModule();
    var adminBookmarkModule = BookmarkTableModule.getModule();
    function deleteUserBookmark(element) {
        var data = $(element).parent().parent().find('td:nth-child(2)').text();
        $.ajax({
            url: "/main/user-bookmark/delete",
            type: "post",
            data: {data: data},
            success: function (responseData) {
                var result = JSON.parse(responseData);
            }
        });
    }

    var tbodyHandlerGenerator = function (type, bookmarkModule) {
        return (function () {

            $.ajax({
                url: '/main/'+type+'/get',
                type: 'post',
                data: {},
                success: function (responseData) {
                    var result = JSON.parse(responseData);
                    bookmarkModule.setData(result);
                    if (bookmarkModule.getData().length > 0) {
                        $.each(bookmarkModule.getData(), function (i, d) {
                            var tmp = $('<tr data-index="' + i + '"><td class="user-bookmark-alarm-td" onclick="$(this).parent().find(\'.user-bookmark-search-word-td\').click()"><span class="badge">N</span></td><td class="user-bookmark-search-word-td">' + d.word + '</td><td><span class="user-bookmark-count-td">' + d.count + '</span></td><td class="user-history-remove-td"><label class="btn btn-default btn-sm close-search-option-btn">-</label></td></tr>');
                            tmp.find('.close-search-option-btn').click(function (e) {
                                var data = $(this).parent().parent().find('td:nth-child(2)').text();
                                $.ajax({
                                    url: '/main/'+type+'/delete',
                                    type: 'post',
                                    data: {data: data},
                                    success: function (responseData) {
                                        var result = JSON.parse(responseData);
                                    }
                                });
                                $(this).parent().parent().remove();
                            });
                            bookmarkModule.getContainer().find('tbody').append(tmp);
                            tmp.find('.user-bookmark-search-word-td').click(function () {
                                var el = $(this).parent();
                                lastQuery = JSON.parse(bookmarkModule.getData()[parseInt(el.attr('data-index'))].word);
                                removeAllRelDiv();
                                $.ajax({
                                    url: '/main/searching',
                                    type: 'post',
                                    data: {"data": (bookmarkModule.getData()[parseInt(el.attr('data-index'))]).word},
                                    contentType: "application/x-www-form-urlencoded; charset=UTF-8",
                                    success: function (responseData) {
                                        var data = JSON.parse(responseData);
                                        tableData = data;
                                        if (!data) {
                                            alert("존재하지 않는 ID입니다");
                                            return false;
                                        }
                                        var html = '<tbody>';
                                        $.each(data, function (i, tdata) {
                                            html += '<tr><td>' + tdata.number + '</td>';
                                            var priorityEl = $('');
                                            priorityEl.find('select').val(tdata.priority);
                                            html += '<td>' + '<select><option>1</option><option>2</option><option>3</option><option>4</option><option>5</option><option>6</option><option>7</option><option>8</option><option>9</option></select>' + '</td>';
                                            html += '<td>' + tdata.groupName + '</td>';
                                            html += '<td>' + tdata.publishedDate + '</td>';
                                            html += '<td>' + tdata.savedDate + '</td>';
                                            html += '<td class="author-td author' + i + '" title="' + tdata.author + '" href="#">' + tdata.author +
                                                    '<span class="nickname-td">' + (tdata.nickname != undefined ? ('(' + tdata.nickname + ')') : '') + '</span>' + '</td>';
                                            //rel-author
                                            html += '<td class="relation-td rel-author' + i + '" title="' + tdata.referencedAuthor + '" href="#">' + tdata.referencedAuthor + '</td>';
                                            if (tdata.r == 't') {
                                                tdata.r = '<span class="glyphicon glyphicon-ok"></span>';
                                            } else {
                                                tdata.r = '';
                                            }
                                            if (tdata.e == 't') {
                                                tdata.e = '<span class="glyphicon glyphicon-ok"></span>';
                                            } else {
                                                tdata.e = '';
                                            }
                                            html += '<td class="check-r' + i + '" title="' +
                                                    tdata.author + ' - 참조저자' +
                                                    '" href="#">' + tdata.r + '</td>';
                                            html += '<td class="check-e">' + tdata.e + '</td>';
                                            html += '<td class="content-td">' + tdata.contents + '</td>';
                                            html += '<td>' + tdata.note1 + '</td>';
                                            html += '<td>' + tdata.note2 + '</tr></td>';
                                        });
                                        html += '</tbody>'
                                        $('#book-table tbody').hide(300, function () {
                                            $('#book-table tbody').remove();
                                            html = $(html);
                                            html.hide();
                                            $('#book-table').append(html);
                                            $.each(data, function (i, tdata) {
                                                $('#book-table select').eq(i).val(tdata.priority);
                                                $('#book-table select').eq(i).change(function () {
//                                console.error($(this).val());
                                                    setPriority($(this));
                                                })
                                            });
                                            html.show(300, function () {
                                                addCheckEBtnListener();

                                                $.each(data, function (i, tdata) {
                                                    addAuthorClickListener(i, tdata);
                                                    addCheckRBtnListener(i, tdata);
                                                    addRelAuthorClickListener(i, tdata);
                                                    addContentTdClickListener(i, tdata.contents);
                                                });
                                                highLightResult();
                                            });
                                        });
                                    }
                                });
                            });
                        });
                    } else {
                        var tmp = $('<tr style="height: 100%;"><td style="border: 0;">등록된 북마크가 없습니다.</td></tr>');
                        bookmarkModule.getContainer().find('tbody').append(tmp);
                    }
                }
            });
        });
    };

    $(document).ready(function () {
        userBookmarkModule.setTitle('User Bookmark Alarm');
        userBookmarkModule.setContainer($('#alarm-user-bookmark'));
        userBookmarkModule.setTBodyGenerator(tbodyHandlerGenerator('user-bookmark',userBookmarkModule));
        userBookmarkModule.init();
        userBookmarkModule.generateTBody();

        adminBookmarkModule.setTitle('Admin Bookmark Alarm');
        adminBookmarkModule.setContainer($('#alarm-admin-bookmark'));
        adminBookmarkModule.setTBodyGenerator(tbodyHandlerGenerator('admin-bookmark', adminBookmarkModule));
        adminBookmarkModule.init();
        adminBookmarkModule.generateTBody();

        $(window).resize(function () {
            $('#content').height($(window).height() - 197);
            totalGraph.refresh();
            authorTotalGraph.refresh();
            if (authorGraph != undefined) {
                authorGraph.refresh();
            }
        });
        $('#content').height($(window).height() - 197);

        $(document).ajaxComplete(function (e, xhr, settings) {
            if (xhr.status === 403) {
                window.location.replace('/')
            }
        });

        $(window).resize(
                function () {
                    //            $('#content').height($(window).height());
                    $('#search-wrapper').height(
                            $(window).height() - 197);
                    //            console($(document).width() + 'px');
                    $('#menu-wrapper').height(
                            $(window).height() - 197);
                    //            $('#book-table').attr('data-height', $(window).height() - 194 - 200)
                    //            $('#book-table').height($(window).height() - 194 - 200)
                    $('#result-table-wrapper').height(
                            $(window).height() - 197 - 130);

                });
        $('#search-wrapper').height($(window).height() - 197);
        $('#menu-wrapper').height($(window).height() - 197);
        //        $('#book-table').height($(window).height() - 194 - 200)
        $('#result-table-wrapper').height(
                $(window).height() - 197 - 130);
        //        $('#book-table').width($('#result-table-wrapper').width());

        $('#book-table').colResizable({
            resizeMode: 'flex',
            initC: ${colSize}
        });

        $('#result-table-wrapper').scroll(function () {
            $('#book-table-header').css("top",
                    252 - $('#book-table').offset().top);
        });
    });

    function setRelTablePos() {
        if (relStartPos.top < relStartPos.maxTop) {
            relStartPos.left += 15;
            relStartPos.top += 15;
        } else {
            relStartPos.count++;
            relStartPos.left = relStartPos.iLeft + (relStartPos.count * 15);
            relStartPos.top = relStartPos.iTop;
        }
    }

    function removeAllRelDiv() {
        $('.relative-table-wrapper').remove();
    }

    $('#highlight-checkbox').click(function () {
        $('.matched-content').toggleClass('highlight-background');
    });

    function highLightResult() {
        for (i = 0; i < lastQuery.data.length; i++) {
//            var regex = new RegExp("(" + RegExp.escape(lastQuery.data[i].input) + ")", "gi");
            var regex = lastQuery.data[i].input;
//            var regex = new RegExp("(" + RegExp.escape('tom') + ")", "gi");
            if (lastQuery.data[i].category == '저자') {
                $.each($('.author-td'), function (i, contentTd) {
                    $(contentTd).html($(contentTd).html().replace(regex, '<span class="matched-content">' + regex + '</span>'));
                });
            } else if (lastQuery.data[i].category == '내용') {
                $.each($('.content-td'), function (i, contentTd) {
                    $(contentTd).html($(contentTd).html().replace(regex, '<span class="matched-content">' + regex + '</span>'));
//                    console.error($(contentTd).text());
                });
            } else if (lastQuery.data[i].category == '참조') {
                $.each($('.relation-td'), function (i, contentTd) {
                    $(contentTd).html($(contentTd).html().replace(regex, '<span class="matched-content">' + regex + '</span>'));
                });
            }
        }
    }

    RegExp.escape = function (str) {
        var specials = /[.*+?|()\[\]{}\\$^]/g; // .*+?|()[]{}\$^
        return str.replace(specials, "\\$&");
    };


    function initPagination(current, from, to, lastPage, cssSelector) {
        var pageController = $('.pagination');
//        var pageController = $(cssSelector);
        pageController.children().remove();
        var pageEl = $('<li><a href="#" aria-label="Previous"><span aria-hidden="true">«</span></a></li>')
        if (from == 1) {
            pageEl.addClass('disabled');
        }
        pageController.append(pageEl);

        for (i = from; i <= to; i++) {
            pageEl = $('<li class="page-btn"><a href="#">' + i + '</a></li>');
            if (i == current) {
                pageEl.addClass('active');
            }
            pageController.append(pageEl);
        }
        pageEl = $('<li><a href="#" aria-label="Next"><span aria-hidden="true">»</span></a></li>');
        if (to == lastPage) {
            pageEl.addClass('disabled');
        }
        pageController.append(pageEl);
    }

    jQuery.fn.tableToCSV = function () {

        var clean_text = function (text) {
            text = text.replace(/"/g, '""');
            return '"' + text + '"';
        };

        $(this).each(function () {
            var table = $(this);
            var caption = $(this).find('caption').text();
            var title = [];
            var rows = [];

            $(this).find('tr').each(function () {
                var data = [];
                $(this).find('th').each(function () {
                    var text = clean_text($(this).text());
                    title.push(text);
                });
                $(this).find('td').each(function () {
                    var text = clean_text($(this).text());
                    data.push(text);
                });
                data = data.join(",");
                rows.push(data);
            });
            title = title.join(",");
            rows = rows.join("\n");

            var csv = title + rows;
            var uri = 'data:text/csv;charset=utf-8,' + encodeURIComponent(csv);
            var download_link = document.createElement('a');
            download_link.href = uri;
            var ts = new Date().getTime();
            if (caption == "") {
                download_link.download = ts + ".csv";
            } else {
                download_link.download = caption + "-" + ts + ".csv";
            }
            document.body.appendChild(download_link);
            download_link.click();
            document.body.removeChild(download_link);


        });

    };

    function addAuthorClickListener(i, tdata) {

        var content = $('<div class="popover-content-wrapper' + i + '" style="display: none;">' +
                '<div class="input-group input-group-sm" style=" width:100%">' +
                '<span class="input-group-addon" style="width: 70px">저자</span>' +
                '<input type="text" class="form-control popover-input-author" disabled>' +
                '</div>' +
                '<div class="input-group input-group-sm" style="width:100%">' +
                '<span class="input-group-addon" style="width: 70px" >별명</span>' +
                '<input type="text" class="form-control popover-input popover-input-nickname">' +
                '<span class="input-group-btn">' +
                '<label class="btn btn-default btn-sm btn-identity-check popover-input" style="width:70px;">중복 확인</label></span>' +
                '</div>' +
                '<div class="input-group input-group-sm" style="width:100%">' +
                '<span class="input-group-addon" style="width: 70px;" disabled >수정시간</span>' +
                '<input type="text" class="form-control popover-input-modified-time" disabled>' +
                '</div>' +
                '<div class="input-group input-group-sm" style=" width:100%">' +
                '<span class="input-group-addon" style="width: 70px" >우선순위</span>' +
                '<span class="input-group-addon" style="width:calc(100% - 70px);" ><select class="popover-input popover-input-priority"><option>1</option><option>2</option><option>3</option><option>4</option><option>5</option><option>6</option><option>7</option><option>8</option><option>9</option></select></span>' +
                '</div>' +
                '<div class="input-group input-group-sm" style="width:100%; height: 60px;">' +
                '<span class="input-group-addon" style="width: 70px" >메모</span>' +
                '<textarea class="form-control popover-input popover-input-note" style="height: 60px;resize: none;"></textarea>' +
                '</div>' +
                '<div style="padding-top: 15px; position:relative">' +
                '<label class="btn btn-default btn-sm btn-modify-nickname"  style="width:70px;">편집</label>' +
                '<label class="btn btn-default btn-sm btn-popover-close" style="width:70px;position: absolute;right: 0; ">취소</label>' +
                '</div></div>');

        $('.author' + i).popover({
            html: true,
            content: function () {
                return content.html();
            },
            container: '#book-table',
            template: '<div class="popover popover-author-td"><div class="arrow"></div><div class="popover-inner"><h3 class="popover-title"></h3><div class="popover-content"><p></p></div></div></div>',
            placement: 'auto'
        }).on('show.bs.popover', function () {
            //remove popover when other popover appeared
            $('.popover-author-td').popover('hide');
        }).on('shown.bs.popover', function () {
            //handle after popover shown
            var clickedTd = $(this);
            $('.popover-input-author').val(tdata.author);
            $('.btn-popover-close').click(function (e) {
                $('.popover-author-td').popover('hide');
            });

            $('.popover-input').attr('disabled', '');

            //update nickname
            $('.popover .btn-modify-nickname').click(function (e) {
                if ($(this).text() == '편집') {
                    $('.popover-input').removeAttr('disabled');
                    $(this).toggleClass('btn-primary').text('저장');
                } else {
                    if ($('.btn-identity-check').attr('disabled') != undefined) {
                        $.ajax({
                            url: "/main/nickname/update",
                            type: "post",
                            data: {
                                "nickname": $('.popover-input-nickname').val(),
                                "author": $('.popover-input-author').val(),
//                                "lastModifiedDate": $('.popover-input-modified-time').val(),
                                "priority": $('.popover-input-priority').val(),
                                "note": $('.popover-input-note').val()
                            },
                            success: function (responseData) {
                                if (responseData == 'true') {
                                    $('.popover .btn-identity-check').attr('disabled', '');
                                    $('.popover .btn-modify-nickname').toggleClass('btn-primary').text('편집');
                                    clickedTd.find('.nickname-td').text('(' + $('.popover-input-nickname').val() + ')');
                                    $('.popover').remove();
                                    $('.popover-input').attr('disabled', '');
                                } else {
                                    //when nickname not checked
                                    alert('send error');
                                }
                            }
                        });
                    } else {
                        alert('중복 확인을 해 주세요.');
                    }
                }
            });

            //when popover opened get nickname info from server
            $.ajax({
                url: "/main/nickname/get",
                type: "post",
                data: {
                    "author": $('.popover-input-author').val()
                },
                success: function (responseData) {
                    var result = JSON.parse(responseData);
//                    console.error(responseData);
                    $('.popover-input-nickname').val(result.nickname);
                    $('.popover-input-modified-time').val(result.lastModifiedDate);
                    $('.popover-input-priority').val(result.priority);
                    $('.popover-input-note').val(result.note);
                }
            });

            $('.popover .btn-identity-check').click(function (e) {
                $.ajax({
                    url: "/main/nickname/check",
                    type: "post",
                    data: {
                        "nickname": $('.popover-input-nickname').val(),
                        "author": $('.popover-input-author').val()
                    },
                    success: function (responseData) {
                        if (responseData == 'true') {
                            $('.popover .btn-identity-check').attr('disabled', '');
                            $('.popover .btn-identity-check').append('<span class="glyphicon glyphicon-ok" style="color:#3ce63d;"></span>');
                            $('.popover .popover-input-nickname').on('input', function () {
                                $('.popover .btn-identity-check span').remove();
                                $('.popover .btn-identity-check').removeAttr('disabled');
                            });
                        } else {
                            alert('이미 같은 별명이 존재합니다.');
                        }
                    }
                });
            });

            $('#book-table').on('hidden.bs.popover', function (e) {
                $(e.target).data("bs.popover").inState = {click: false, hover: false, focus: false}
            });
        });
    }

    function addRelAuthorClickListener(i, tdata) {

        var content = $('<div class="popover-content-wrapper' + i + '" style="display: none;">' +
                '<div class="input-group input-group-sm" style=" width:100%">' +
                '<span class="input-group-addon" style="width: 70px">저자</span>' +
                '<input type="text" class="form-control popover-input-author" disabled>' +
                '</div>' +
                '<div class="input-group input-group-sm" style="width:100%">' +
                '<span class="input-group-addon" style="width: 70px" >별명</span>' +
                '<input type="text" class="form-control popover-input popover-input-nickname">' +
                '<span class="input-group-btn">' +
                '<label class="btn btn-default btn-sm btn-identity-check popover-input" style="width:70px;">중복 확인</label></span>' +
                '</div>' +
                '<div class="input-group input-group-sm" style="width:100%">' +
                '<span class="input-group-addon" style="width: 70px;" disabled >수정시간</span>' +
                '<input type="text" class="form-control popover-input-modified-time" disabled>' +
                '</div>' +
                '<div class="input-group input-group-sm" style=" width:100%">' +
                '<span class="input-group-addon" style="width: 70px" >우선순위</span>' +
                '<span class="input-group-addon" style="width:calc(100% - 70px);" ><select class="popover-input popover-input-priority"><option>1</option><option>2</option><option>3</option><option>4</option><option>5</option><option>6</option><option>7</option><option>8</option><option>9</option></select></span>' +
                '</div>' +
                '<div class="input-group input-group-sm" style="width:100%; height: 60px;">' +
                '<span class="input-group-addon" style="width: 70px" >메모</span>' +
                '<textarea class="form-control popover-input popover-input-note" style="height: 60px;resize: none;"></textarea>' +
                '</div>' +
                '<div style="padding-top: 15px; position:relative">' +
                '<label class="btn btn-default btn-sm btn-modify-nickname"  style="width:70px;">편집</label>' +
                '<label class="btn btn-default btn-sm btn-popover-close" style="width:70px;position: absolute;right: 0; ">취소</label>' +
                '</div></div>');

        $('.rel-author' + i).popover({
            html: true,
            content: function () {
                return content.html();
            },
            container: '#book-table',
            template: '<div class="popover popover-author-td"><div class="arrow"></div><div class="popover-inner"><h3 class="popover-title"></h3><div class="popover-content"><p></p></div></div></div>',
            placement: 'auto'
        }).on('show.bs.popover', function () {
            //remove popover when other popover appeared
            $('.popover-author-td').popover('hide');
        }).on('shown.bs.popover', function () {
            //handle after popover shown
            var clickedTd = $(this);
            $('.popover-input-author').val(tdata.referencedAuthor);
            $('.btn-popover-close').click(function (e) {
                $('.popover-author-td').popover('hide');
            });

            $('.popover-input').attr('disabled', '');

            //update nickname
            $('.popover .btn-modify-nickname').click(function (e) {
                if ($(this).text() == '편집') {
                    $('.popover-input').removeAttr('disabled');
                    $(this).toggleClass('btn-primary').text('저장');
                } else {
                    if ($('.btn-identity-check').attr('disabled') != undefined) {
                        $.ajax({
                            url: "/main/nickname/update",
                            type: "post",
                            data: {
                                "nickname": $('.popover-input-nickname').val(),
                                "author": $('.popover-input-author').val(),
//                                "lastModifiedDate": $('.popover-input-modified-time').val(),
                                "priority": $('.popover-input-priority').val(),
                                "note": $('.popover-input-note').val()
                            },
                            success: function (responseData) {
                                if (responseData == 'true') {
                                    $('.popover .btn-identity-check').attr('disabled', '');
                                    $('.popover .btn-modify-nickname').toggleClass('btn-primary').text('편집');
                                    clickedTd.find('.nickname-td').text('(' + $('.popover-input-nickname').val() + ')');
                                    $('.popover').remove();
                                    $('.popover-input').attr('disabled', '');
                                } else {
                                    //when nickname not checked
                                    alert('send error');
                                }
                            }
                        });
                    } else {
                        alert('중복 확인을 해 주세요.');
                    }
                }
            });

            //when popover opened get nickname info from server
            $.ajax({
                url: "/main/nickname/get",
                type: "post",
                data: {
                    "author": $('.popover-input-author').val()
                },
                success: function (responseData) {
                    var result = JSON.parse(responseData);
//                    console.error(responseData);
                    $('.popover-input-nickname').val(result.nickname);
                    $('.popover-input-modified-time').val(result.lastModifiedDate);
                    $('.popover-input-priority').val(result.priority);
                    $('.popover-input-note').val(result.note);
                }
            });

            $('.popover .btn-identity-check').click(function (e) {
                $.ajax({
                    url: "/main/nickname/check",
                    type: "post",
                    data: {
                        "nickname": $('.popover-input-nickname').val(),
                        "author": $('.popover-input-author').val()
                    },
                    success: function (responseData) {
                        if (responseData == 'true') {
                            $('.popover .btn-identity-check').attr('disabled', '');
                            $('.popover .btn-identity-check').append('<span class="glyphicon glyphicon-ok" style="color:#3ce63d;"></span>');
                            $('.popover .popover-input-nickname').on('input', function () {
                                $('.popover .btn-identity-check span').remove();
                                $('.popover .btn-identity-check').removeAttr('disabled');
                            });
                        } else {
                            alert('이미 같은 별명이 존재합니다.');
                        }
                    }
                });
            });

            $('#book-table').on('hidden.bs.popover', function (e) {
                $(e.target).data("bs.popover").inState = {click: false, hover: false, focus: false}
            });
        });
    }

    function setPriority(priority) {
        var bookId = priority.parent().parent().find('td').eq(0).text();
        var data = new Object();
        data.bookId = bookId;
        data.priority = priority.val();
        $.ajax({
            url: '/main/priority/update',
            type: 'post',
            data: {'data': JSON.stringify(data)},
//            data: {"data": jsonSearchInfo()},
            contentType: "application/x-www-form-urlencoded; charset=UTF-8",
            success: function (responseData) {
            }
        });
    }

    function addContentTdClickListener(i, contents) {
        $('.content-td').popover({
            html: true,
            content: function () {
                return $(this).text();
            },
            template: '<div class="popover popover-content-td"><div class="arrow"></div><div class="popover-inner"><h3 class="popover-title"></h3><button type="button" class="close" data-dismiss="popover" aria-label="Close"><span aria-hidden="true">×</span></button><div class="popover-content"><p></p></div></div></div>',
            container: '#book-table',
            placement: 'auto'
        }).on('show.bs.popover', function () {
            //remove popover when other popover appeared
            $('.popover-content-td').popover('hide');
        }).on('shown.bs.popover', function () {
            $('.popover-content-td .close').click(function () {
                $('.popover-content-td').popover('hide');
            });
        });
    }

    function addCheckRBtnListener(i) {
        $('.check-r' + i).click(function () {
            var tmpEl = $('<div class="alert bg-white alert-dismissible fade in border-gray relative-table-wrapper" style="position: absolute; z-index: 10; width: 700px; left:' + relStartPos.left + 'px;top:' + relStartPos.top + 'px;" role="alert"><button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">×</span></button>' +
                    '<div class="relative-title">' + tableData[i].author + ' - ' + tableData[i].referencedAuthor + '</div>' +
                    '<div style="font-size: 10px;margin-top: 10px;margin-bottom: 10px;position: relative;left: 450px;">' +
                    '<span class="relative-author-from-date">' + lastQuery.fromDate + '</span>' + (lastQuery.fromDate == '' && lastQuery.toDate == '' ? '' : '</span><span> ~ </span><span class="relative-author-to-date">' + lastQuery.toDate + '</span>') +
                    '</div>' +
                    '<div class="draggable-content-container"><div style="overflow: scroll;height: 300px;">' +
                    '<table class="table table-hover table-fixed table-bordered table-striped table-condensed" style="font-size: 11px; margin-bottom: 0;">' +
                    '<thead><tr><th>저장시간</th><th>저자</th><th>참조저자</th><th>내용</th></tr></thead>' +
                    '<tbody></tbody></table></div><div><nav aria-label="..." style="text-align: center; margin-top:10px;">' +
                    '<ul class="pagination pagination-sm" style="margin: 0 auto;">' +
                    '<li><a href="#" aria-label="Previous" class="disabled"><span aria-hidden="true">«</span></a></li>' +
                    '<li><a href="#" class="active">1</a></li>' +
                    '<li><a href="#">2</a></li>' +
                    '<li><a href="#">3</a></li>' +
                    '<li><a href="#">4</a></li>' +
                    '<li><a href="#">5</a></li>' +
                    '<li><a href="#" aria-label="Next"><span aria-hidden="true">»</span></a></li></ul></nav></div>' +
                    '<label class="btn btn-primary btn-export" style="position: absolute;right: 15px;bottom: 15px;font-size: 11px;">export</label></div>');
            setRelTablePos();
            $('body').append(tmpEl);
            for (j = 0; j < 20; j++) {
                var content = $('<tr><td>' +
                        '2014-05-' + j + '</td>' +
                        '<td>저자' + j + '</td>' +
                        '<td>참조저자' + j + '</td>' +
                        '<td class="relative-table-content-td">always work (for bootstrap' + j + '</td></tr>');

                tmpEl.find('tbody').append(content);
                content.find('.relative-table-content-td').popover({
                    html: true,
                    content: function () {
                        return $(this).text();
                    },
                    template: '<div class="popover popover-relative-content-td"><div class="arrow"></div><div class="popover-inner"><h3 class="popover-title"></h3><button type="button" class="close" data-dismiss="popover" aria-label="Close"><span aria-hidden="true">×</span></button><div class="popover-content"></div></div></div>',
                    container: tmpEl.find('.draggable-content-container'),
                    placement: 'auto'
                }).on('show.bs.popover', function () {
                    //remove popover when other popover appeared
                    $('.popover-relative-content-td').popover('hide');
                }).on('shown.bs.popover', function () {
                    $('.popover-relative-content-td .close').click(function () {
                        $('.popover-relative-content-td').popover('hide');
                    });
                });
            }
            tmpEl.draggable({cancel: '.draggable-content-container'});
            var tarEl = $(this);
            tmpEl.find('.btn-export').click(function (e) {
                exportCsv(tmpEl.find('table'));
                $.ajax({
                    url: "/main/e-check",
                    type: "post",
                    data: {"bookId": tarEl.parent().find('td').eq(0).text()},
                    success: function (responseData) {
                        var data = JSON.parse(responseData);

//                    console.error(tarEl);

                        tarEl.parent().find('td').eq(8).find('span').remove();
                        tarEl.parent().find('td').eq(8).append('<span class="glyphicon glyphicon-ok"></span>');
                    }
                });
            });
            $.ajax({
                url: "/main/r-check",
                type: "post",
                data: {"bookId": tarEl.parent().find('td').eq(0).text()},
                success: function (responseData) {
//                                var data = JSON.parse(responseData);

//                    console.error(tarEl);
                    tarEl.find('span').remove();
                    tarEl.append('<span class="glyphicon glyphicon-ok"></span>');
//                    console.log(html);
                }
            });
        });
    }

    function addCheckEBtnListener() {
        $('.check-e').click(function () {
            var tarEl = $(this);
            $.ajax({
                url: "/main/e-check",
                type: "post",
                data: {"bookId": tarEl.parent().find('td').eq(0).text()},
                success: function (responseData) {
                    var data = JSON.parse(responseData);

//                    console.error(tarEl);

                    tarEl.find('span').remove();
                    tarEl.append('<span class="glyphicon glyphicon-ok"></span>');
//                    console.log(html);
                }
            });
        });
    }

</script>
</body>
</html>