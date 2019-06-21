// 다음 행동에 쓰일 이미지 리스트
ArrayList<PImage> imageFrames=new ArrayList<PImage>();
// 행동 중 배경에서 이용될 이미지 리스트
ArrayList<PImage> backFrames;
// 이미지 모드로 사용시 리스트를 관리 / imageList 는 동영상을 같이 관리합니다
String[] imageList=new String[0], backList=new String[0];
// 분리자: 클릭에 따른 애니메이션/영상재생여부 분리 식별자
FloatList seperator=new FloatList();
// 편집모드 여부
JSONObject setup;
// 장면 번호와 화면 번호
int scene=0, frame=0;

void setup() {
  size(1366, 854);

  try { // 설정파일 불러오기
    setup=loadJSONObject("data/setup.json");
  }
  catch(Exception e) {
    println("loadSetup Err:", e);
  }
  boolean isSourceImage=setup.getString("source")=="image";
  File backFiles;
  File files=new File(sketchPath()+"/data/"+(isSourceImage?"image/shot/":"video"));
  File[] listOfImages=files.listFiles();
  for (int i=0, j=listOfImages.length; i<j; i++) 
    imageList=append(imageList, listOfImages[i].toString());
  if (isSourceImage) {
    backFrames=new ArrayList<PImage>();
    backFiles=new File(sketchPath()+"/data/image/loop/");
    File[] listOfBack=backFiles.listFiles();
    for (int i=0, j=listOfBack.length; i<j; i++)
      backList=append(backList, listOfBack[i].toString());
  }
}

void draw() {
}

// 이미지 로딩 여부를 확인해서 작업 정도값을 되돌려준다
float checkImageLoader(String type) {
  float suc=0;
  boolean tog=type=="image";
  for (int i=tog?imageFrames.size():backFrames.size(); i>=0; i--) {
    float imgWidth=0;
    if (type=="image")
      imgWidth=imageFrames.get(i).width>0?1:imageFrames.get(i).width;
    else 
    imgWidth=backFrames.get(i).width>0?1:backFrames.get(i).width;
    suc+=imgWidth;
  }

  return suc/float(tog?imageList.length:backList.length);
}
