var csrfToken = undefined;
var modal = undefined;
var message = undefined;
var mensajeCorrecto = "Su correo electronico fue registrado satisfactoriamente revise su bandeja de entrada para completar la suscripcion";
var mensajeError = "Su correo electronico ya fue registrado previamente";
$(document).ready(function() {
  csrfToken = $('meta[name="csrf-token"]').attr('content');
  modal = $('#notificationModal').modal();
  message = $('#message')[0];
  console.log(csrfToken);
  let closeModal = document.getElementById("restart-button");
  closeModal.addEventListener("click",() => {
		modal.modal('close');
  });
  let submit = document.getElementById("submit");
  submit.addEventListener("click",function(event){
    event.preventDefault();
    subscribe();
  });
});

function subscribe() {
  if(validate()){
    let userEmail = $('#email')[0];
    let json = {
      'email': userEmail.value,
      'authenticity_token': csrfToken
    };
    console.log(userEmail.value);
    console.log(json);
    enviarJson(json);
  }
}

enviarJson = (json) => {
  let xmlHttpRequest = new XMLHttpRequest();
  let action = "http://localhost:3000/subscribers/new";
  xmlHttpRequest.open("POST",action,true);
  xmlHttpRequest.setRequestHeader('Content-Type','application/json');
  xmlHttpRequest.onreadystatechange = (respuesta) => {
    if(xmlHttpRequest.readyState == 4) {
      if(xmlHttpRequest.status == 200) {
        let response = JSON.parse(respuesta.target.response);
        if (response.registered) {
          message.innerHTML = mensajeCorrecto;
        }else{
          message.innerHTML = mensajeError;
        }
        modal.modal('open');
      }
    }
  }

  jsonData = JSON.stringify(json);
  xmlHttpRequest.send(jsonData);
}

validate = () => {
  let userEmail = $('#email')[0];
  let emailRegex = new RegExp("[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$");
  let validateEmail = emailRegex.test(userEmail.value);
  return validateEmail;
}
