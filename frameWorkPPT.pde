// 다음 행동에 쓰일 이미지 리스트
ArrayList<PImage> imageFrames=new ArrayList<PImage>();
// 행동 중 배경에서 이용될 이미지 리스트
ArrayList<PImage> backFrames=new ArrayList<PImage>();
// 분리자: 클릭에 따른 애니메이션/영상재생여부 분리 식별자
FloatList seperator=new FloatList();
// 편집모드 여부
boolean editMode=false;
// 장면 번호와 화면 번호
int scene=0, frame=0;

void setup() {
  JSONObject json=loadJSONObject("data/setup.json");
  editMode=json.getBoolean("editMode");
}

void draw() {
}
