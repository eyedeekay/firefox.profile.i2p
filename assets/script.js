
function Show(divid) {
  var element = document.getElementById(divid)
  element.classList.remove("hidden")
  element.classList.add("highlight")
  element.classList.remove("lowlight")
}

function Hide(divid) {
  var element = document.getElementById(divid)
  element.classList.add("hidden")
  element.classList.add("lowlight")
  element.classList.remove("highlight")
}

function ShowWindows() {
    var element = document.getElementById("windows")
    if (element.classList.contains("hidden")) {
        Show("windows")
    }else{
        Hide("windows")
    }
    element.onclick = ShowWindows
}

function ShowOSX() {
    var element = document.getElementById("osx")
    if (element.classList.contains("hidden")) {
        Show("osx")
    }else{
        Hide("osx")
    }
    element.onclick = ShowOSX
}

function ShowLinux() {
    var element = document.getElementById("linux")
    if (element.classList.contains("hidden")) {
        Show("linux")
    }else{
        Hide("linux")
    }
    element.onclick = ShowLinux
}

function ShowNotes() {
    var element = document.getElementById("notes")
    if (element.classList.contains("hidden")) {
        Show("notes")
    }else{
        Hide("notes")
    }
    element.onclick = ShowNotes
}

function ShowWhonix() {
    var element = document.getElementById("whonix")
    if (element.classList.contains("hidden")) {
        Show("whonix")
    }else{
        Hide("whonix")
    }
    element.onclick = ShowWhonix
}

function ShowFinger() {
    var element = document.getElementById("finger")
    if (element.classList.contains("hidden")) {
        Show("finger")
    }else{
        Hide("finger")
    }
    element.onclick = ShowFinger
}
window.onload = function () {
    var OSName="windows";
    if (navigator.appVersion.indexOf("Win")!=-1) OSName="windows";
    if (navigator.appVersion.indexOf("Mac")!=-1) OSName="osx";
    if (navigator.appVersion.indexOf("X11")!=-1) OSName="linux";
    if (navigator.appVersion.indexOf("Linux")!=-1) OSName="linux";
    Hide("windows")
    Hide("osx")
    Hide("linux")
    Hide("notes")
    Hide("whonix")
    Hide("finger")
    Show(OSName)
    var wel = document.getElementsByClassName('windows');
    for (var i = 0, len = wel.length; i < len; i++) {
        wel[i].classList.add("shown")
        wel[i].onclick = ShowWindows
    }
    var mel = document.getElementsByClassName('osx');
    for (var i = 0, len = mel.length; i < len; i++) {
        mel[i].classList.add("shown")
        mel[i].onclick = ShowOSX
    }
    var lel = document.getElementsByClassName('linux');
    for (var i = 0, len = lel.length; i < len; i++) {
        lel[i].classList.add("shown")
        lel[i].onclick = ShowLinux
    }
    var nel = document.getElementsByClassName('notes');
    for (var i = 0, len = nel.length; i < len; i++) {
        nel[i].classList.add("shown")
        nel[i].onclick = ShowNotes
    }
    var hel = document.getElementsByClassName('whonix');
    for (var i = 0, len = hel.length; i < len; i++) {
        hel[i].classList.add("shown")
        hel[i].onclick = ShowWhonix
    }
    var fel = document.getElementsByClassName('finger');
    for (var i = 0, len = fel.length; i < len; i++) {
        fel[i].classList.add("shown")
        fel[i].onclick = ShowFinger
    }
}
