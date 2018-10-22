<?php

//proxy client (gunakan proxy dibawah jika menggunakan jaringan diskominfo. silahkan ganti dengan yang lain jika berbeda proxy)
//$proxy = '10.15.3.20:80';
 
//The JSON data.
$jsonDataEncoded = $myvars;

// echo $jsonDataEncoded;

//Initiate cURL.
$ch = curl_init($url);

//Set the url
curl_setopt($ch, CURLOPT_URL, $url);

//Set the proxy ( jika tidak menggunakan proxy harap hapus / comment sintaks dibawah ini !!!)
//curl_setopt($ch, CURLOPT_PROXY, $proxy);

curl_setopt($ch, CURLOPT_RETURNTRANSFER, false);

curl_setopt($ch, CURLOPT_CUSTOMREQUEST, "POST");
 
//Tell cURL that we want to send a POST request.
curl_setopt($ch, CURLOPT_POST, true);
 
//Attach our encoded JSON string to the POST fields.
curl_setopt($ch, CURLOPT_POSTFIELDS, $jsonDataEncoded);
 
//Set the content type to application/json
curl_setopt($ch, CURLOPT_HTTPHEADER, array('Content-Type: application/json')); 
 
//Execute the request
$result = curl_exec($ch);

//Get status 
$status = curl_getinfo($ch, CURLINFO_HTTP_CODE);

if ( $status != 201 ) {
	die("Error: call to URL $url failed with status: $status, response: $result, curl_error: " . curl_error($ch) . ", curl_errno: " . curl_errno($ch));
}

//Close to save memory
curl_close($ch);

$response = json_decode($result, true);

?>