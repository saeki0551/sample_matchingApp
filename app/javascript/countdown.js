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

var serializedArray = localStorage.getItem('myArray');
var array = JSON.parse(serializedArray);

function users(user_data) {
  return user_data.email === email && user_data.deleted_at === deleted_at;
}

if (array.find(users)) {
  var target_user_data = array.find(users);
  var endTime = target_user_data.endTime;
} else {
  const user_data_array = [];
  user_data_array.push(user_data);
  const serializedArray = JSON.stringify(user_data_array);
  localStorage.setItem('myArray', serializedArray);
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