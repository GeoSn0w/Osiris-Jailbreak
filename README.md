# Osiris-Jailbreak

<p align="center">
<B> ONLY FOR DEVELOPERS! </B>
</p>

An incomplete iOS 11.2 -> iOS 11.3.1 Jailbreak by GeoSn0w (@FCE365) using multi_path (CVE-2018-4241) by Ian Beer and #QiLin by Jonathan Levin.

This jailbreak is under development and in no way whatsoever intended for general public usage. Please don't run this jailbreak on your device until I finish it as it has the potential to mess stuff up. If you're an average iOS user, please stick with Electra Jailbreak. It is safer and more stable. This is my first public jailbreak and I am doing it just for learning purposes.


<p align="center"> Sideloading iOS apps with Xcode is sooo <s>2015</s> 2018 (multi_path) </p>


### Curent Development (Help needed)
-> Test on iOS 11.2.1 iPod Touch 6th Generation and iPhone 6 iOS 11.3.1

May take multiple attempts for the exploit to run properly.

### What works:
<ul>
<li> Properly runs the exploit and grants QiLin SEND right to the Kernel task_port (aka tfp0). </li>
  <li> Nukes the Sandbox. </li>
  <li> Nukes AMFI for CodeSign bypass </li>
  <li> Successfully remounts the ROOTFS as R/W on iOS 11.2.6 and lower. Waiting for QiLin to be updated soon for iOS 11.3.x </li>
    <li> Contains Jonathan Levin's binpack for 64-Bit and drops it. <-- Could be improved. </li>
</ul>

### What doesn't work:
<ul>
  <li> Has no Cydia and I doubt I'll even bother with the current status Cydia's in. </li>
  <li> No Substrate. </li>
  <li> Doesn't remount the FS on iOS 11.3.x (to be fixed soon). </li>
  <li> General code structure. This is just a sketch and code can be greatly improved. </li>
 </ul>
 
 Just in case it isn't clear for everyone yet:
 <ul>
  <li> THIS DOES NEED APPLE DEVELOPER ACCOUNT (Because of the Multi Path entitlement used in multi_path).</li>
  <li> I will swap the mtcp exploit with vfs once Ian Beer drops it. </li>
  <li> THIS COMES "AS-IS". NO FURTHER SUPPORT SHOULD BE EXPECTED OR WILL BE GIVEN. USE AT YOUR OWN RISK! I AM NOT RESPONSIBLE IF IT FUCKS YOUR DEVICE! </li>
</ul>

### New Team Members:
The following developers to which I am thankful agreed to help me with this
<ul>
  <li> https://twitter.com/auxiliumdev </li>
  <li> https://twitter.com/MidnightChip </li>
 </ul>
 
### Contact me
GeoSn0w (@FCE365): https://twitter.com/FCE365

### References
<ul>
  <li> QiLin: http://newosxbook.com/QiLin/ </li>
    <li> multi_path: https://bugs.chromium.org/p/project-zero/issues/detail?id=1558 </li>
  </ul>
