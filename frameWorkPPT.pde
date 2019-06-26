// 다음 행동에 쓰일 이미지 리스트
ArrayList<PImage> imageFrames=new ArrayList<PImage>();
// 행동 중 배경에서 이용될 이미지 리스트
ArrayList<PImage> backFrames;
// 분리자: 클릭에 따른 애니메이션 분리 식별자(프레임 애니메이션용/프레임)
IntList sepFrame=new IntList()
// 분리자: frameRate를 씬 별로 설정해줌(프레임 애니메이션용)
  ,setFrameRate=new IntList();
// 분리자: 클릭에 따른 영상재생여부 분리 식별자(영상용/초)
FloatList sepVideo=new FloatList();
// 편집모드 여부, 기반되는 소스 등 설정
JSONObject setup;
// 장면 번호와 화면 번호 / 4자리 고정수로 받아오기
int scene=0, frame=0;
// 작업 프로세스를 표기한다(작업용 화면) / {Front, back}: 1은 작업 끝(invisible), 0-1은 퍼센트
float[] loadingProc={1, 1};
// 보고있는 페이지에서 몇개의 이미지가 사용되는지를 확인하는 번호(프레임 애니메이션용)
int[] cacheNumber={0, 0};

void setup() {
  size(1366, 854);

  try { // 설정파일 불러오기
    setup=loadJSONObject("data/setup.json");
  }
  catch(Exception e) { // 설정파일 없으면 초기화파일 만들고 설정잡기
    println("loadSetup Err:", e);
    JSONObject tmpSetup=new JSONObject();
    tmpSetup.setBoolean("editMode", true);
    tmpSetup.setString("source", "image");
    saveJSONObject(tmpSetup, "data/setup.json");
    setup=tmpSetup;
    println(" > reinit setup.json");
  }
  // 소스파일이 이미지인지의 여부를 확인
  boolean isSourceImage=setup.getString("source")=="image";
  // 파일 리스트 받아오기 재작성 필요
}

void draw() {
}

// 폴더 내부 주소를 반환한다(전체주소, 자료 링크용)
StringList listAsString(String dir) {
  StringList result=new StringList();
  File file=new File(sketchPath()+"/"+dir);
  File[] listFiles=file.listFiles();
  for (int i=0, j=listFiles.length; i<j; i++)
    result.append(listFiles[i].toString());
  return result;
}

// 자료 불러온다(이미지 기반 작업용)
ArrayList<PImage> loadWithList(StringList list) {
  ArrayList<PImage> result=new ArrayList<PImage>();
  for (int i=0, j=list.size(); i<j; i++)
    result.set(i, requestImage(list.get(i)));
  return result;
}

// 이미지 불러오기 진행 정도를 표기해준다(이미지 기반 작업용)
float[] loadingProcCalc() {
  float[] result={1, 1};
  float[] number={0, 0};

  if (imageFrames.size()>0) {
    for (int i=0, j=imageFrames.size(); i<j; i++)
      if (imageFrames.get(i).width == 0) {
        // Image is not yet loaded
      } else if (imageFrames.get(i).width == -1) {
        println("loadProcCalc_Err while imageframe-"+i+" loading");
      } else {
        number[0]++;
      }
    result[0]=number[0]/float(imageFrames.size());
  }

  if (backFrames.size()>0) {
    for (int i=0, j=backFrames.size(); i<j; i++)
      if (backFrames.get(i).width == 0) {
        // Image is not yet loaded
      } else if (backFrames.get(i).width == -1) {
        println("loadProcCalc_Err while backframe-"+i+" loading");
      } else {
        number[0]++;
      }
    result[1]=number[1]/float(backFrames.size());
  }

  return result;
}
