

(async () => {
  console.log("Loading Hand Landmarks model...");
  const vision = await import(
    "https://cdn.jsdelivr.net/npm/@mediapipe/tasks-vision@0.10.0/vision_bundle.js"
  );
  const { HandLandmarker, FilesetResolver } = vision;
  const demosSection = document.getElementById("demos");
  let handLandmarker = undefined;
  let runningMode = "IMAGE";
  let enableWebcamButton;
  let webcamRunning = false;
  // Before we can use HandLandmarker class we must wait for it to finish
  // loading. Machine Learning models can be large and take a moment to
  // get everything needed to run.
  const createHandLandmarker = async () => {
    const vision = await FilesetResolver.forVisionTasks(
      "https://cdn.jsdelivr.net/npm/@mediapipe/tasks-vision@0.10.0/wasm"
    );
    handLandmarker = await HandLandmarker.createFromOptions(vision, {
      baseOptions: {
        modelAssetPath: `https://storage.googleapis.com/mediapipe-models/hand_landmarker/hand_landmarker/float16/1/hand_landmarker.task`,
        delegate: "GPU",
      },
      runningMode: runningMode,
      numHands: 1,
    });
    demosSection.classList.remove("invisible");
  };
  createHandLandmarker();
  /********************************************************************
// Demo 2: Continuously grab image from webcam stream and detect it.
********************************************************************/
  const video = document.getElementById("webcam");
  const canvasElement = document.getElementById("output_canvas");
  const canvasCtx = canvasElement.getContext("2d");
  // Check if webcam access is supported.
  const hasGetUserMedia = () => {
    var _a;
    return !!((_a = navigator.mediaDevices) === null || _a === void 0
      ? void 0
      : _a.getUserMedia);
  };
  // If webcam supported, add event listener to button for when user
  // wants to activate it.
  if (hasGetUserMedia()) {
    enableWebcamButton = document.getElementById("webcamButton");
    enableWebcamButton.addEventListener("click", enableCam);
  } else {
    console.warn("getUserMedia() is not supported by your browser");
  }
  // Enable the live webcam view and start detection.
  function enableCam(event) {
    if (!handLandmarker) {
      console.log("Wait! objectDetector not loaded yet.");
      return;
    }
    if (webcamRunning === true) {
      webcamRunning = false;
      enableWebcamButton.innerText = "ENABLE PREDICTIONS";
    } else {
      webcamRunning = true;
      enableWebcamButton.innerText = "DISABLE PREDICTIONS";
    }
    // getUsermedia parameters.
    const constraints = {
      video: true,
    };
    // Activate the webcam stream.
    navigator.mediaDevices.getUserMedia(constraints).then((stream) => {
      video.srcObject = stream;
      video.addEventListener("loadeddata", predictWebcam);
    });
  }
  let lastVideoTime = -1;
  const tipIds = [4, 8, 12, 16, 20];
  let previousFingers = [];
  let results = undefined;
  let testing = false;

  function calculateAngle(v1, v2) {
    let dotProduct = v1.x * v2.x + v1.y * v2.y;
    let magnitudeProduct = Math.sqrt(
      (v1.x ** 2 + v1.y ** 2) * (v2.x ** 2 + v2.y ** 2)
    );
    let angleInRadians = Math.acos(dotProduct / magnitudeProduct);
    let angleInDegrees = angleInRadians * (180 / Math.PI);
    return angleInDegrees;
  }
  function test(fingers, lmList) {
    if (fingers[1] === 1 && fingers[0] === 1 && previousFingers.length > 0) {
      let ax = lmList[0].x - previousFingers[0].x;
      // console.log(ax);
      if (ax < -0.06) {
        console.log("Scrolling Right");
        window.direction = "right";
      } else if (ax > 0.06) {
        console.log("Scrolling Left");
        window.direction = "left";
      } else {
        window.direction = "stop";
      }
    }
  }
  function fingersUp(lmList) {
    const fingers = [];
    if (!lmList) return fingers;
    // Xác định trạng thái của ngón cái
    if (lmList[tipIds[0]].x > lmList[tipIds[0] - 1].x) {
      fingers.push(1);
    } else {
      fingers.push(0);
    }

    // Xác định trạng thái của các ngón tay còn lại
    for (let id = 1; id < 5; id++) {
      if (lmList[tipIds[id]].y < lmList[tipIds[id] - 2].y) {
        fingers.push(1);
      } else {
        fingers.push(0);
      }
    }

    return fingers;
  }

  async function predictWebcam() {
    canvasElement.style.width = video.videoWidth;
    canvasElement.style.height = video.videoHeight;
    canvasElement.width = video.videoWidth;
    canvasElement.height = video.videoHeight;
    // Now let's start detecting the stream.
    if (runningMode === "IMAGE") {
      runningMode = "VIDEO";
      await handLandmarker.setOptions({ runningMode: "VIDEO" });
    }
    let startTimeMs = performance.now();
    if (lastVideoTime !== video.currentTime) {
      lastVideoTime = video.currentTime;
      results = handLandmarker.detectForVideo(video, startTimeMs);
    }
    canvasCtx.save();
    canvasCtx.clearRect(0, 0, canvasElement.width, canvasElement.height);
    if (results.landmarks) {
      for (const landmarks of results.landmarks) {
        drawConnectors(canvasCtx, landmarks, HAND_CONNECTIONS, {
          color: "#00FF00",
          lineWidth: 5,
        });
        drawLandmarks(canvasCtx, landmarks, { color: "#FF0000", lineWidth: 2 });
      }
    }
    canvasCtx.restore();
    // Call this function again to keep predicting when the browser is ready.
    if (webcamRunning === true) {
      window.requestAnimationFrame(predictWebcam);
      if (!testing) {
        testing = true;
        setTimeout(() => {
            const fingers = fingersUp(results.landmarks[0]);
            test(fingers, results.landmarks[0]);
            if (results.landmarks[0]) {
              previousFingers = results.landmarks[0];
            }
            testing = false;
          }, 300);
        }

    }
  }
  console.log(window.direction)

})(); // end IIFE
