'use strict';

window.addEventListener('load', function() {
    for (let item of document.getElementsByClassName('redirect-here')) {
        item.href = `/sign-in?redirect=${encodeURIComponent(window.location.pathname + window.location.search)}`;
    }
});