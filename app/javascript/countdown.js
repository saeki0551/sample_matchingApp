var countDown = document.getElementById("seconds");
var message = document.getElementById("message");
var email = document.getElementById("email").textContent;
var deleted_at = document.getElementById("deleted_at").textContent;

var targetTime = countDown.textContent;
targetTime = parseInt(targetTime);
targetMinitues = Math.floor(targetTime / 60);
targetSeconds = targetTime % 60;

targetTime = new Date();
targetTime.setMinutes(targetTime.getMinutes() + targetMinitues);
targetTime.setSeconds(targetTime.getSeconds() + targetSeconds);
var endTime = targetTime.getTime();

var user_data = {
  email: email,
  deleted_at: deleted_at,
  endTime: endTime
}

var already_user = JSON.parse(localStorage.getItem('myArray'));

if (already_user) {
  if(already_user.email === email && already_user.deleted_at === deleted_at) {
    var endTime = already_user.endTime;
  } else {
    localStorage.setItem('myArray', JSON.stringify(user_data));
  } 
} else {
  localStorage.setItem('myArray', JSON.stringify(user_data));
}

function updateCountDown(){
  const now = new Date().getTime();
  const distance = endTime - now;

  const minutes = Math.floor(distance % (1000 * 60 * 60) / (1000 * 60));
  const seconds = Math.floor(distance % (1000 * 60) / 1000);

  countDown.textContent = `${String(minutes)}分 ${String(seconds)}秒`;

  if(distance < 0){
    clearInterval(interval);
    message.textContent = "再度、新規登録できます。";
  }
}
var interval = setInterval(updateCountDown, 1000);
updateCountDown();