window.onload = function(){
	const countDown = document.getElementById("seconds");
	const message = document.getElementById("message");

  let targetTime = countDown.textContent;
	targetTime = parseInt(targetTime);
	targetMinitues = Math.floor(targetTime / 60);
	targetSeconds = targetTime % 60;
	
	targetTime = new Date();
	targetTime.setMinutes(targetTime.getMinutes() + targetMinitues);
	targetTime.setSeconds(targetTime.getSeconds() + targetSeconds);
		
	const endTime = targetTime.getTime();

  if (localStorage.getItem('endTime')) {
		function updateCountDown(){
			const now = new Date().getTime();
			const endTime = localStorage.getItem('endTime');
			const distance = endTime - now;
	
			const minutes = Math.floor(distance % (1000 * 60 * 60) / (1000 * 60));
			const seconds = Math.floor(distance % (1000 * 60) / 1000);
	
			countDown.textContent = `${String(minutes)}分 ${String(seconds)}秒`;
		
			if(distance < 0){
				clearInterval(interval);
				message.textContent = '再度、新規登録できます。';
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
	
		  localStorage.setItem('endTime', endTime);

			if(distance < 0){
				clearInterval(interval);
				message.textContent = '再度、新規登録できます。';
			}
		}
	
		const interval = setInterval(updateCountDown, 1000);
		updateCountDown();
	}
}