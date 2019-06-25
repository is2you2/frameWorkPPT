// 다음 행동에 쓰일 이미지 리스트
ArrayList<PImage> imageFrames=new ArrayList<PImage>();
// 행동 중 배경에서 이용될 이미지 리스트
ArrayList<PImage> backFrames;
// 분리자: 클릭에 따른 애니메이션 분리 식별자(프레임 애니메이션용/프레임)
IntList sepFrame=new IntList();
// 분리자: 클릭에 따른 영상재생여부 분리 식별자(영상용/초)
FloatList sepVideo=new FloatList();
// 편집모드 여부, 기반되는 소스 등 설정
JSONObject setup;
// 장면 번호와 화면 번호 / 4자리 고정수로 받아오기
int scene=0, frame=0;
// 작업 프로세스를 표기한다(작업용 화면) / {Front, back}: -1은 작업 없음(invisible), 0-1은 퍼센트
float[] loadingProc={-1, -1};

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

// 폴더를 읽고 자료와 자료 로딩정보를 반환한다
ArrayList<PImage> loadWithList(String dir) {
  ArrayList<PImage> result=null;
  // 작성 필요
  return result;
}
