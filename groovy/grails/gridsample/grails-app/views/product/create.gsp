  
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main" />
        <title>Create Product</title>         
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir:'')}">Home</a></span>
            <span class="menuButton"><g:link class="list" action="list">Product List</g:link></span>
        </div>
        <div class="body">
            <h1>Create Product</h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${product}">
            <div class="errors">
                <g:renderErrors bean="${product}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" method="post" >
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class='prop'>
                                <td valign='top' class='name'>
                                    <label for='fileName'>File Name:</label>
                                </td>
                                <td valign='top' class='value ${hasErrors(bean:product,field:'fileName','errors')}'>
                                    <input type="text" id='fileName' name='fileName' value="${fieldValue(bean:product,field:'fileName')}"/>
                                </td>
                            </tr> 
                        
                            <tr class='prop'>
                                <td valign='top' class='name'>
                                    <label for='name'>Name:</label>
                                </td>
                                <td valign='top' class='value ${hasErrors(bean:product,field:'name','errors')}'>
                                    <input type="text" id='name' name='name' value="${fieldValue(bean:product,field:'name')}"/>
                                </td>
                            </tr> 
                        
                            <tr class='prop'>
                                <td valign='top' class='name'>
                                    <label for='type'>Type:</label>
                                </td>
                                <td valign='top' class='value ${hasErrors(bean:product,field:'type','errors')}'>
                                    <input type="text" id='type' name='type' value="${fieldValue(bean:product,field:'type')}"/>
                                </td>
                            </tr> 
                        
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><input class="save" type="submit" value="Create"></input></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
