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
		
	const endTime = targetTime.getTime();

	// localStorage.clear();

  if (localStorage.getItem('user_data_array')) {
		function updateCountDown(){
			const now = new Date().getTime();
			const user_data_array = JSON.parse(localStorage.getItem('user_data_array'));
			console.log(user_data_array)
			console.log(user_data_array.email)
			console.log(user_data_array.endTime)


			const distance = user_data_array.email - now;
	
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
	} else {
		function updateCountDown(){
			const now = new Date().getTime();
			const distance = endTime - now;
	
			const minutes = Math.floor(distance % (1000 * 60 * 60) / (1000 * 60));
			const seconds = Math.floor(distance % (1000 * 60) / 1000);
	
			countDown.textContent = `${String(minutes)}分 ${String(seconds)}秒`;
	
			let user_data = {
				email: email,
				endTime: endTime
			}
			
			localStorage.setItem('user_data_array', JSON.stringify(user_data));

			if(distance < 0){
				clearInterval(interval);
				message.textContent = "再度、新規登録できます。";
			}
		}
	
		const interval = setInterval(updateCountDown, 1000);
		updateCountDown();
	}
}