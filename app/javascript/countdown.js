window.onload = function(){
  const countDown = document.getElementById("seconds");
  const message = document.getElementById("message");
  const email = document.getElementById("email").textContent;

  let targetTime = countDown.textContent;
	targetTime = parseInt(targetTime);
	targetMinitues = Math.floor(targetTime / 60);
	targetSeconds = targetTime % 60;

	targetTime = new Date();
	targetTime.setMinutes(targetTime.getMinutes() + targetMinitues);
	targetTime.setSeconds(targetTime.getSeconds() + targetSeconds);
	let endTime = targetTime.getTime();

	let user_data = {
		email: email,
		endTime: endTime
	}
	
	function users(user_data) {
		return user_data.email === email;
	}

	const serializedArray2 = localStorage.getItem('myArray');
	const array = JSON.parse(serializedArray2);

	if (array.find(users)) {
		var target_user_data = array.find(users);
		endTime = target_user_data.endTime;
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
	const interval = setInterval(updateCountDown, 1000);
	updateCountDown();
}



	









//  } else {
// 	 const user_data_array = [];
// 	 let user_data = {
// 		 email: email,
// 		 endTime: endTime
// 	 }
// 	 user_data_array.push(user_data)
//  }
