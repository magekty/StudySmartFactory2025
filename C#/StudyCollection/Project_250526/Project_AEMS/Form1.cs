using System;
using System.Collections.Generic;
using System.IO;
using System.Windows.Forms;
using System.Windows.Forms.DataVisualization.Charting;

namespace Project_AEMS
{
    public partial class Form1 : Form
    {
        private Button btnLoadCsv;          //csv불러오기 버튼
        private DataGridView dataGridView1; //데이터그리드뷰
        private Chart chart1;               //차트
        private Label lblStatus;            //내부CO2 라벨
        private Timer monitorTimer;         //실시간 구동 타이머
        private List<string[]> csvDataRows; //csv데이터셋보관
        private int currentRowIndex = 0;    //데이터 행 시작값 초기화
        private int dataTypeCnt = 7;        //데이터종류 개수

        /*
            주제: 스마트팜 환경 모니터링 프로그램
            팀원: 김태영

            마일스톤 : 기획1, 자료수집(수집,분석, 정제)1, 구현3, 테스트및리팩토링1

            주제 선정 배경 : 강사님이 스마트팜을 하신다고해서 스마트팜에 대해 궁금해서 선택
            스마트팜에 적용할 수 있는게 뭐가있을까 고민하다가 스마트팜환경모니터링 
            프로그램을 만들기로 기획함 

            자료 출처 : 스마트팜코리아 - 스마트농업 데이터셋(딸기)
            
            기획 : API 및 실제 데이터를 적용할 수 있도록 csv식 정형데이터를 이용해 구현 및 시각화.
            구현수준은 배운것을 기반으로 제작 가능한 난이도 설정

            구성 : csv자료 구성 설명, 화면 설명

            코딩 설명 : 

            확장성 : 정형 데이터 셋을 이용해서 스마트팜 관련 데이터를 적용하기 쉽고 
            추후 API 및 실제 데이터를 대입하기 용이함

            개발중어려움 : 데이터셋을 수집하다 보니 csv로 된 파일만 있어서 공부를 해야 했던것
            차트를 적용했을때 생각 로직과 많이 달랐고 여러차례 테스트하느라 시간 지연

            아쉬웠던점 : 함께 팀원과 협업을 못한것과
            디자인을 신경못쓴것때문에 가시성이 안좋다

            좋았던점 : 농업과 스마트팩토리에 대해서 조금더 알게된것

            시현 장면 :

            QnA : 

         */


        public Form1()
        {
            InitializeComponent();      // 기본 컴포넌트 초기화 실행
            InitializeMonitorTimer();   //모니터 Timer 초기화 실행
        }


        private void InitializeMonitorTimer()   //모니터 Timer 초기화 메소드
        {
            monitorTimer = new Timer();         //새 Timer생성
            comboBox1.SelectedIndex = 0;        //콤보박스 선택된 초기값
            monitorTimer.Interval = 1000;       //지연시간 1초로 초기화
            monitorTimer.Tick += timer1_Tick;   //Timer에 실행구문 추가
        }

        private void btnLoadCsv_Click(object sender, EventArgs e)   //csv불러오기버튼 메소드
        {
            OpenFileDialog ofd = new OpenFileDialog();  //새 OpenFileDialog 생성
            ofd.Filter = "CSV 파일 (*.csv)|*.csv";      //파일 필터 설정
            if (ofd.ShowDialog() == DialogResult.OK)    //파일열기화면 성공시 실행
            {
                LoadCsvRows(ofd.FileName);  //Csv읽기(파일경로) 실행
                InitializeDataGrid();       //데이터그리드 초기화 실행
                InitializeChart();          //차트 초기화 실행
                monitorTimer.Interval = 
                    int.Parse(comboBox1.SelectedItem.ToString());  //콤보박스 설정된 지연시간 입력
                monitorTimer.Start();       //Timer 시작
              }
        }

        private void LoadCsvRows(string filePath)   //Csv읽기(파일경로) 메소드
        {
            csvDataRows = new List<string[]>();     //csv데이터셋보관 배열 생성
            //파일 기반의 StreamReader 생성
            using (StreamReader reader = new StreamReader(filePath))    
            {
                while (!reader.EndOfStream)         //reader에 스트림끝에 도달할때까지
                {
                    string line = reader.ReadLine();    //각 행의 데이터 line문자열에 입력
                    //line문자열에 데이터를 ,단위로 분리후 values문자열 배열에 입력
                    string[] values = line.Split(',');  
                    csvDataRows.Add(values);        //가공된 데이터를 csvDataRows행에 추가
                }
            }
            progressBar1.Minimum = 0;   //진행사항 최소치 범위
            //진행사항 최대치 범위(총csvDataRows행/데이터종류)
            progressBar1.Maximum = csvDataRows.Count / dataTypeCnt; 

        }

        private void InitializeDataGrid()   //데이터그리드 초기화 메소드
        {
            dataGridView1.Columns.Clear();  //데이터그리드 열 비우기
            if (csvDataRows.Count > 0)      //csvDataRows에 데이터행이 있을시
            {
                //csvDataRows[0] 첫행은 목록이라 header에 임시로 담았다가
                foreach (string header in csvDataRows[0])   
                {
                    //dataGridView1열에 목록을 추가(컬럼명, 헤더명)
                    dataGridView1.Columns.Add(header, header);  
                }
            }
            dataGridView1.Rows.Clear();    //데이터그리드 행 비우기
        }

        private void InitializeChart()  //차트 초기화 메소드
        {
            chart1.Series.Clear();      //차트 시리즈 비우기
            chart1.Legends.Clear();     //차트 범례 비우기

            chart1.Titles.Add("농업환경데이터");    //차트 타이틀 추가
            Legend legend = new Legend($"Legend1"); //새 범례변수에 새 Legend1범례 입력
            legend.Docking = Docking.Right;         //범례방향 고정
            legend.Font = new System.Drawing.Font("맑은 고딕", 9);  //범례 글꼴,사이즈 설정
            chart1.Legends.Add(legend);             //차트에 범례 추가

            for (int i = 0; i < dataTypeCnt; i++)   //데이터종류만큼 반복
            {
                chart1.Series.Add($"Series{i + 1}");    //차트에 각 데이터 종류마다 시리즈 추가
                chart1.Series[$"Series{i + 1}"].ChartType = SeriesChartType.Line;   //차트 타입Line
                chart1.Series[$"Series{i + 1}"].Legend = $"Legend1";    //각 시리즈를 범례에 연결
            }

            //각 시리즈에 범례명 설정
            chart1.Series["Series1"].LegendText = "내부CO2";
            chart1.Series["Series2"].LegendText = "내부습도";
            chart1.Series["Series3"].LegendText = "내부온도";
            chart1.Series["Series4"].LegendText = "내부일사량";
            chart1.Series["Series5"].LegendText = "근권수분함량";
            chart1.Series["Series6"].LegendText = "근권토양EC";
            chart1.Series["Series7"].LegendText = "근권토양Ph";

            for (int i = 0; i < dataTypeCnt; i++)   //데이터종류만큼 반복
            {
                if (i > 0)  //초기 차트 범위는 차트 생성시 설정되서 제외하고 생성
                {
                    chart1.ChartAreas.Add($"ChartArea{i + 1}"); //추가된 차트 범위를 추가
                    //각 시리즈에 차트 범위를 연결
                    chart1.Series[$"Series{i + 1}"].ChartArea = $"ChartArea{i + 1}";   
                }
                //각 차트에 표기되는 X축 수치의 간격 설정
                chart1.ChartAreas[$"ChartArea{i + 1}"].AxisX.LabelStyle.Interval = 24;
            }

        }
        



        private void timer1_Tick(object sender, EventArgs e)    //Timer에 실행구문 추가 메소드
        {
            //모든 데이터를 읽어들였을지 무결성 검사
            if (csvDataRows == null || csvDataRows.Count <= 1 || currentRowIndex >= csvDataRows.Count - 1)
            {
                lblStatus.Text = "모든 데이터를 로드했습니다.";
                lblStatus.ForeColor = System.Drawing.Color.Blue;
                monitorTimer.Stop();    //데이터를 다 읽었으니 Timer 정지
                return;
            }
            CheckWarning();         //경고 확인 실행
            progressBar1.Value++;   //프로그래스바 진행사항 값 누적
        }

        private void CheckWarning() //경고 확인 메소드
        {
            for (int i = 0; i < dataTypeCnt; i++)   //데이터종류만큼 반복
            {
                //Console.WriteLine($"98371: index: {currentRowIndex} progress:{progressBar1.Value} progressMax:{progressBar1.Maximum}");

                currentRowIndex++;  //읽어들인 데이터 인덱스 값 누적
                //csvDataRows의 각 행을 rowData배열에 입력
                string[] rowData = csvDataRows[currentRowIndex];    
                dataGridView1.Rows.Add(rowData);    //dataGridView1에 각 행에 rowData값 추가
                //실제 11번째인덱스에 있는 측정값(문자열)을 double값으로 형변환 성공가능시 
                //out 변수에 반환하는 TryParse메소드를 이용해 참,거짓 판별
                if (double.TryParse(rowData[11], out double value)) 
                {
                    //차트의 각 시리즈마다 Y축 값 입력
                    chart1.Series[$"Series{i + 1}"].Points.AddY(value); 
                    switch (i)  //데이터종류가 어떤거인지에 따라 실행(ex: 0 = CO2, 1 = 습도)
                    {
                        case 0:
                            // 경고범위(700 < value > 1500)에 벗어난다면 조건
                            if (value < 700 || value > 1500)    
                            {
                                lblStatus.Text = $"내부CO2 -  경고";    //라벨에 경고문구 출력
                                lblStatus.ForeColor = System.Drawing.Color.Red; //라벨에 문구 색변경
                            }
                            else
                            {
                                lblStatus.Text = "내부CO2 - 정상";
                                lblStatus.ForeColor = System.Drawing.Color.Green;
                            }

                            break;
                        case 1:
                            if (value < 50 || value > 100)
                            {
                                label1.Text = $"내부습도 -  경고";
                                label1.ForeColor = System.Drawing.Color.Red;
                            }
                            else
                            {
                                label1.Text = "내부습도 - 정상";
                                label1.ForeColor = System.Drawing.Color.Green;
                            }

                            break;
                        case 2:
                            if (value < 5 || value > 26)
                            {
                                label2.Text = $"내부온도 -  경고";
                                label2.ForeColor = System.Drawing.Color.Red;
                            }
                            else
                            {
                                label2.Text = "내부온도 - 정상";
                                label2.ForeColor = System.Drawing.Color.Green;
                            }

                            break;
                        case 3:
                            break;
                        case 4:
                            if (value < 30 || value > 70)
                            {
                                label4.Text = $"지습 -  경고";
                                label4.ForeColor = System.Drawing.Color.Red;
                            }
                            else
                            {
                                label4.Text = "지습 - 정상";
                                label4.ForeColor = System.Drawing.Color.Green;
                            }

                            break;
                        case 5:
                            if (value > 120)
                            {
                                label5.Text = $"토양EC -  경고";
                                label5.ForeColor = System.Drawing.Color.Red;
                            }
                            else
                            {
                                label5.Text = "토양EC - 정상";
                                label5.ForeColor = System.Drawing.Color.Green;
                            }

                            break;
                        case 6:
                            if (value < 5.5f || value > 7.0f)
                            {
                                label6.Text = $"토양PH -  경고";
                                label6.ForeColor = System.Drawing.Color.Red;
                            }
                            else
                            {
                                label6.Text = "토양PH - 정상";
                                label6.ForeColor = System.Drawing.Color.Green;
                            }

                            break;
                        default:
                            break;
                    }

                }

            }
        }

        private void Form1_Load(object sender, EventArgs e)
        {

        }
    }
}
