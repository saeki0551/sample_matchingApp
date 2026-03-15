window.onload = function(){
	const countDown = document.getElementById("seconds");
	const message = document.getElementById("message");

  let targetTime = countDown.textContent;
	targetTime = parseInt(targetTime);
	targetTime = new Date().setSeconds(targetTime);

	function updateCountDown(){
		const now = new Date().getTime();
		const distance = targetTime - now;

		const minutes = Math.floor(distance % (1000 * 60 * 60) / (1000 * 60));
		const seconds = Math.floor(distance % (1000 * 60) / 1000);
		console.log(seconds);

  	countDown.textContent = `${String(minutes)}分 ${String(seconds)}秒`;

		if(distance < 0){
			clearInterval(interval);
			message.textContent = '再度、新規登録できます。';
		}
  }

	const interval = setInterval(updateCountDown, 1000);
	updateCountDown();
}