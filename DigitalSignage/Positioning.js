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
