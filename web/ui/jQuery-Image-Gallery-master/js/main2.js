/*
 * jQuery Image Gallery Plugin JS Example 2.5
 * https://github.com/blueimp/jQuery-Image-Gallery
 *
 * Copyright 2011, Sebastian Tschan
 * https://blueimp.net
 *
 * Licensed under the MIT license:
 * http://www.opensource.org/licenses/MIT
 */

/*jslint unparam: true, regexp: true */
/*global $, document, window */

$(function () {
    'use strict';
    // Initialize the Image Gallery widget:
    $('#gallery').imagegallery();
    var labelId = $('#labelId').val();
    // Load images via flickr for demonstration purposes:
    $.ajax({
        url: '/bpps/diseaseImageSearch',
        data: {
            labelId: labelId,
            format: 'json',
            method: 'flickr.interestingness.getList',
            api_key: '7617adae70159d09ba78cfec73c13be3'
        },
	    dataType: 'jsonp',
        jsonp: 'jsoncallback'
    }).done(function (data) {
        var gallery = $('#gallery'),
            url;
        $.each(data.photos.photo, function (index, photo) {
            url = photo.url;
            $('<a data-gallery="gallery"/>')
                .append($('<img>').prop('src', url + '_s.jpg'))
                .prop('href', url + '_b.jpg')
                .prop('title', photo.title)
                .appendTo(gallery);
        });
    });

});
