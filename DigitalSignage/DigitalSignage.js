/*Scale Function*/

function scaleX(wdw,x)
{
    return (x/100)*wdw.width;
}

function scaleY(wdw,y)
{
    return (y/100)*wdw.height;
}

/*Positioning Function*/

function rightOf(component,offset)
{
    return component.x + component.width + offset;
}

function leftOf(component,offset)
{
    return component.x - offset;
}

function topOf(component,offset)
{
    return component.y - offset;
}

function bottomOf(component,offset)
{
    return component.y + component.height + offset;
}

/*HTML Function*/

function regeXecutor(input,regex)
{
    var match;
    var result ="";
    //input = input.replace(new RegExp('[\r\n]', 'gi'), '');
    while (match = regex.exec(input)) { result += match[1]+" "; }

    return result;
}


function request(url, callback) {
    var xhr = new XMLHttpRequest();
    xhr.onreadystatechange = (function(myxhr) {
        return function() {
            callback(myxhr);

        }
    })(xhr);
    xhr.open('GET', url, true);
    xhr.send('');
}



