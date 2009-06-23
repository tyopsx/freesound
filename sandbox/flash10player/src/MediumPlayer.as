package {	import ui.IPlayerControls;	import ui.IPlayerControlsObserver;	import ui.ISoundDisplay;	import ui.ISoundDisplayObserver;	import ui.medium.SoundDisplay;		import flash.display.Sprite;	import flash.events.KeyboardEvent;	import flash.ui.Keyboard;			[Embed(source='../media/VeraMono.ttf', fontName='VeraMono', fontWeight='normal', unicodeRange='u+0000-u+00ff' )]    [SWF( backgroundColor='0xffffff', width='120', height='71', frameRate='60')]    public class MediumPlayer extends Sprite implements ISoundManagerObserver, ISoundDisplayObserver, IPlayerControlsObserver    {        private var _baseUrl : String, _waveformUrl : String, _spectralUrl : String, _soundUrl : String;        private var _durationEstimate : Number;        private var _soundDisplay : SoundDisplay;        private var _soundManager : BasicSoundManager;        private var _loop:Boolean;                public function MediumPlayer()        {            if (loaderInfo.parameters["baseUrl"])	            _baseUrl = loaderInfo.parameters["baseUrl"];            else            	_baseUrl = "../media/";            	            if (loaderInfo.parameters["waveformUrl"])	            _waveformUrl = loaderInfo.parameters["waveformUrl"];            else            	_waveformUrl = "waveform_medium.png";            if (loaderInfo.parameters["spectralUrl"])	            _spectralUrl = loaderInfo.parameters["spectralUrl"];            else            	_spectralUrl = "spectral_medium.jpg";                        if (loaderInfo.parameters["soundUrl"])            	_soundUrl = loaderInfo.parameters["soundUrl"];            else	            _soundUrl = "preview.mp3";	                        if (loaderInfo.parameters["duration"])            	_durationEstimate = loaderInfo.parameters["duration"];            else	            _durationEstimate = 3457.95;	            	        _loop = false;            _soundDisplay = new SoundDisplay(120, 71, _baseUrl + _waveformUrl, _baseUrl + _spectralUrl, _durationEstimate);            _soundDisplay.addSoundDisplayObserver(this);            _soundDisplay.addPlayerControlsObserver(this);            addChild(_soundDisplay);            stage.focus = this;			            addEventListener(KeyboardEvent.KEY_DOWN, onKeyPressed);         }        private function onKeyPressed(e : KeyboardEvent) : void        {            switch (e.keyCode)            {            	case Keyboard.SPACE:	            {	                createSoundManager();							                if (_soundManager)	                {	                    if (_soundManager.playing)		                    	_soundManager.pause();		                    else		                    	_soundManager.play();	                }	                break;	            }	            case Keyboard.RIGHT:	            {	                if (_soundManager)	                	_soundManager.forward();					break;	            }	            case Keyboard.LEFT:	            {	                if (_soundManager)	                	_soundManager.rewind();					break;	            }	            case 83:	            {					_soundDisplay.swapBackground();				}            }        }        private function createSoundManager() : void        {            if (!_soundManager)            {                _soundManager = new BasicSoundManager(_baseUrl + _soundUrl, _durationEstimate);				_soundManager.loop = _loop;				_soundManager.addSoundManagerObserver(this);			}        }        public function onSoundDisplayClick(soundDisplay : ISoundDisplay, procent : Number) : void        {            createSoundManager();            _soundManager.jump(procent);   			stage.focus = this;        }        /************ PlayerControl callbacks************************************************/        public function playClicked(playerControls : IPlayerControls) : void         {            createSoundManager();            _soundManager.play();        };        public function pauseClicked(playerControls : IPlayerControls) : void        {            if (_soundManager)            	_soundManager.pause();        };        public function stopClicked(playerControls : IPlayerControls) : void        {            if (_soundManager)		    	_soundManager.stop();        };        public function spectralClicked(playerControls : IPlayerControls) : void        {            _soundDisplay.setSpectralBackground();            _soundDisplay.updateMeasureDisplay();        };        public function waveformClicked(playerControls : IPlayerControls) : void        {            _soundDisplay.setWaveformBackground();            _soundDisplay.updateMeasureDisplay();        };        public function loopOnClicked(playerControls : IPlayerControls) : void        {        	_loop = true;            if (_soundManager)	    		_soundManager.loop = true;        };        public function loopOffClicked(playerControls : IPlayerControls) : void        {        	_loop = false;            if (_soundManager)				_soundManager.loop = false;        };        public function measureOnClicked(playerControls : IPlayerControls) : void        {            _soundDisplay.measureReadout(true);            _soundDisplay.updateMeasureDisplay();        };        public function measureOffClicked(playerControls : IPlayerControls) : void        {            _soundDisplay.measureReadout(false);            _soundDisplay.updateMeasureDisplay();        };        /************ SoundManager callbacks************************************************/        public function onSoundManagerLoading( soundManager : ISoundManager, progress : Number ) : void        {            //_soundDisplay.setSoundDuration(_soundManager.duration);            _soundDisplay.setLoading(progress);        };        public function onSoundManagerError( soundManager : ISoundManager, errorMsg : String ) : void        {            _soundDisplay.displayErrorMessage(errorMsg);        };        public function onSoundManagerLoaded(soundManager : ISoundManager) : void        {            _soundDisplay.setSoundDuration(_soundManager.duration);            _soundDisplay.setLoading(1.0);        };        public function onSoundManagerPlay(soundManager : ISoundManager) : void        {            _soundDisplay.setPlayButtonState(true);        };        public function onSoundManagerPlaying( soundManager : ISoundManager, position : Number, time : Number ) : void        {            _soundDisplay.setPlaying(position, time);        };        public function onSoundManagerPause(soundManager : ISoundManager) : void        {            _soundDisplay.setPlayButtonState(false);        };        public function onSoundManagerStop(soundManager : ISoundManager) : void        {            _soundDisplay.setPlayButtonState(false);        };    }}