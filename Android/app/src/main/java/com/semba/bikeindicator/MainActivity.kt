package com.semba.bikeindicator

import android.media.MediaPlayer
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.os.Handler
import android.view.animation.*
import kotlinx.android.synthetic.main.activity_main.*

class MainActivity : AppCompatActivity() {

    var bikeAnimation: Animation? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
    }

    override fun onStart() {
        super.onStart()
        startLoading(true)

        main_layout?.postDelayed({
            stopAnimation(true)
        }, 5000)
    }

    private fun startLoading(playMusic: Boolean)
    {
        runBikeEnteranceAnimations()
        if (playMusic)
            playBikeSound()
    }

    private fun stopAnimation(playMusic: Boolean)
    {
        runBikeExitAnimations()
        if (playMusic)
            playBikeSound()
    }

    private fun playBikeSound() {
        Handler().postDelayed({
            val mp = MediaPlayer.create(this, R.raw.bike_sound)
            mp.start()
        }, 200)

    }

    private fun runBikeEnteranceAnimations() {

        val animSet = AnimationSet(true)
        animSet.fillAfter = true
        animSet.interpolator = LinearInterpolator()

        val rot = RotateAnimation(0f,-30f)
        rot.duration = 650
        rot.repeatCount = 1
        rot.repeatMode = Animation.REVERSE

        val trans = TranslateAnimation(-900f, 0f, 0f, 0f)
        trans.duration = 1500

        bikeAnimation = AnimationUtils.loadAnimation(this, R.anim.tayar_bike_animation)
        bikeAnimation?.repeatCount = Animation.INFINITE
        bikeAnimation?.repeatMode = Animation.REVERSE

        animSet.addAnimation(bikeAnimation)
        animSet.addAnimation(rot)
        animSet.addAnimation(trans)
        bike_imageView?.startAnimation(animSet)
    }

    private fun runBikeExitAnimations() {

        val animSet = AnimationSet(true)
        animSet.fillAfter = true
        animSet.interpolator = LinearInterpolator()

        val rot = RotateAnimation(0f,-30f)
        rot.duration = 650
        rot.repeatCount = 1
        rot.repeatMode = Animation.REVERSE

        val trans = TranslateAnimation(0f, 1000f, 0f, 0f)
        trans.duration = 1500

        bikeAnimation = AnimationUtils.loadAnimation(this, R.anim.tayar_bike_animation)
        bikeAnimation?.repeatCount = Animation.INFINITE
        bikeAnimation?.repeatMode = Animation.REVERSE

        animSet.addAnimation(bikeAnimation)
        animSet.addAnimation(rot)
        animSet.addAnimation(trans)
        bike_imageView?.startAnimation(animSet)
    }
}
