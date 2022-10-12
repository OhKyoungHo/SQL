package c_info2;

import java.awt.BorderLayout;
import java.awt.GridLayout;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.imageio.ImageIO;
import javax.swing.ImageIcon;
import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JTextArea;
import javax.swing.JTextField;

public class InfoView {
	
	//1. 멤버변수선언
	JFrame f;
	JTextField tfName, tfId, tfTel, tfGender, tfAge, tfHome;
	JTextArea ta;
	JButton bAdd, bShow, bSearch, bDelete, bCancel, bExit;
	
	//비즈니스로직 - 모델단
	//추상 인터페이스를 상속받는 명령어
	InfoModel model;
	
	
	//2. 멤버변수 객체 생성
	/*
	 * 전체 프레임은 BorderLayout으로 지정 
 		- WEST : JPanel 붙이기(GridLayout(6,2)으로 지정)
 		- CENTER : 텍스트에어리어
 		- SOUTH : JPanel 붙이기(GridLayout(1,6)으로 지정)
	 */
	InfoView(){
		f = new JFrame("DBTest");
		tfName = new JTextField(15);
		tfId = new JTextField();
		tfTel = new JTextField();
		tfGender = new JTextField();
		tfAge = new JTextField();
		tfHome = new JTextField();
		bAdd = new JButton("Add");
		bShow = new JButton("Show");
		bSearch = new JButton("Search");
		bDelete = new JButton("Delete");
		bCancel = new JButton("Cancel");
		bExit = new JButton("수정하기");
		ta = new JTextArea(50,10);
		
		try {
			bAdd.setIcon(new ImageIcon(ImageIO.read(getClass().getResource("add.png"))));
			bShow.setIcon(new ImageIcon(ImageIO.read(getClass().getResource("show.png"))));
			bSearch.setIcon(new ImageIcon(ImageIO.read(getClass().getResource("search.png"))));
			bDelete.setIcon(new ImageIcon(ImageIO.read(getClass().getResource("delete.png"))));
			bCancel.setIcon(new ImageIcon(ImageIO.read(getClass().getResource("cancel.png"))));
			bExit.setIcon(new ImageIcon(ImageIO.read(getClass().getResource("exit.png"))));
			System.out.println();
		}catch(Exception ex) {
			System.out.println("no Image");
		}
		
		//모델객체 생성
		try {
			model = new InfoModelImp1();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
		
		
		
	}
	//3. 화면 구성하고 출력
	public void addLayout() {
		f.setLayout(new BorderLayout()); 
		JPanel pWest =  new JPanel(new GridLayout(6,2));
		pWest.add(new JLabel("Name",JLabel.CENTER),tfName);		//label 삽입&가운데 정렬
		pWest.add(tfName);										//textfield 삽입
		pWest.add(new JLabel("ID",JLabel.CENTER));
		pWest.add(tfId);
		pWest.add(new JLabel("Tel",JLabel.CENTER));
		pWest.add(tfTel);
		pWest.add(new JLabel("Sex",JLabel.CENTER));
		pWest.add(tfGender);
		pWest.add(new JLabel("Age",JLabel.CENTER));
		pWest.add(tfAge);
		pWest.add(new JLabel("Home",JLabel.CENTER));
		pWest.add(tfHome);
		f.add(pWest, BorderLayout.WEST);
		
		JPanel pSouth =  new JPanel(new GridLayout(1,6));
		pSouth.add(bAdd);
		pSouth.add(bShow);
		pSouth.add(bSearch);
		pSouth.add(bDelete);
		pSouth.add(bCancel);
		pSouth.add(bExit);
		f.add(pSouth, BorderLayout.SOUTH);
		
		f.add(ta, BorderLayout.CENTER);
		
		f.setBounds(100, 200, 850, 350);						// 크기지정
		f.setVisible(true);										// 창을 화면에 나타낼 것인지 설정 
		f.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		
		
	}
	//add버튼을 눌렀을때
	void eventProc() {
		bAdd.addActionListener(new ActionListener(){	
			public void actionPerformed(ActionEvent e) {
				insertData();
		}//end of ActionListener
		});//end of addActionListener
		
		//show버튼이 눌렸을때
		bShow.addActionListener(new ActionListener(){	
			public void actionPerformed(ActionEvent e) {
				selectAll();
		}//end of ActionListener
		});//end of addActionListener
		
		//bSearch 버튼이 눌렸을때
		bSearch.addActionListener(new ActionListener(){	
			public void actionPerformed(ActionEvent e) {
				selectByTel();
			}//end of ActionListener
		});	//end of addActionListener	
		//전화번호 텍스트 필드에서 엔터쳤을때
		tfTel.addActionListener(new ActionListener(){	
			public void actionPerformed(ActionEvent e) {
				selectByTel();
			}//end of ActionListener
		});	//end of addActionListener	
		
		//bDelete 버튼이 눌렸을때 
		bDelete.addActionListener(new ActionListener(){	
			public void actionPerformed(ActionEvent e) {
				deleteByTel();
			}
		});	
		//bExit 버튼이 눌렸을때(수정)
		bExit.addActionListener(new ActionListener(){	
			public void actionPerformed(ActionEvent e) {
				modify();
				selectAll();
			}
		});	
		
	}//end of eventProc
	/* 함수명 : modifyTel
	 * 인자 : 없음
	 * 리턴값 : void
	 * 역할 : 정보를 수정하는 역할 수행 */
	void modify() {
		try {
		//(1) 입력한 전화번호부 얻어오기
		String tel = tfTel.getText();
		InfoVO vo = new InfoVO();
		//(2) 받은 결과를 각각의 테스트필드에 지정(출력)
		//vo객체에 tf__.getText() 세팅
		vo.setName(tfName.getText());
		vo.setId(tfId.getText());
		vo.setTel(tfTel.getText());
		vo.setGender(tfGender.getText());
		vo.setAge(Integer.parseInt(tfAge.getText()));//age는 int 값이랑 string으로 변경
		vo.setHome(tfHome.getText());
		//(3) 모델단에 modify() 호출(인터페이스 호출)
		model.modify(vo);
		clearText();
		
		}catch(SQLException e) {
			ta.setText("수정실패: " + e.getMessage());
		}
	}//end of modifyTel
	
	/* 함수명 : deleteByTel
	 * 인자 : 없음
	 * 리턴값 : void
	 * 역할 : 내용을 삭제하는 역할 수행 */
	
	void deleteByTel() {
		//(1) 입력한 전화번호부 얻어오기
		String tel = tfTel.getText();
		//(2) 모델단에 deleteByTel() 호출(인터페이스 호출)
		try {
			model.delete(tel);
			//(3) 화면을 지우고
			clearText();
		}catch(SQLException e) {
			ta.setText("삭제실패: " + e.getMessage());
		}
	}
	/* 함수명 : selectByTel
	 * 인자 : 없음
	 * 리턴값 : void
	 * 역할 : 전화번호를 검색하는 역할 수행 */
	void selectByTel() {
		try {
		//(1) 입력한 전화번호 값을 얻어오기
			String tel = tfTel.getText();
		//(2) 모델단에 selectByTel() 호출
			InfoVO vo = model.selectByTel(tel);
		//(3) 받은 결과를 각각의 테스트필드에 지정(출력)
			tfName.setText(vo.getName());
			tfId.setText(vo.getId());
			tfTel.setText(vo.getTel());
			tfGender.setText(vo.getGender());
			tfAge.setText(String.valueOf(vo.getAge()));
			tfHome.setText(vo.getHome());
			
		}catch(Exception ex) {
			ta.setText("전화번호 검색 실패 : " + ex.getMessage());
		}
	}//end of selectByTel

	/* 함수명 : selectAll
	 * 인자 : 없음
	 * 리턴값 : void
	 * 역할 : ta에 내용을 출력하는 역할 수행 */
	void selectAll() {
		try {
			//모델단에 selectAll() 호출
			ArrayList<InfoVO> data = model.selectAll();
			ta.setText("-----검색결과-----\n\n");
			//받은 결과를 각각의 테스트필드에 지정(출력)
			for(InfoVO vo : data) {	//향상된 for문 사용
				ta.append(vo.toString());
			}
			
		} catch (SQLException e) {
			ta.setText("검색실패 :" + e.getMessage());
		}
	}//end of selectAll
	
	/* 함수명 : insertData
	 * 인자 : 없음
	 * 리턴값 : void
	 * 역할 : 정보를 입력하는 역할 수행 */
	
	void insertData() {
		//(1) 사용자입력값 얻어오기
		String name = tfName.getText();
		String id = tfId.getText();
		String tel = tfTel.getText();
		String gender = tfGender.getText();
		int age = Integer.parseInt(tfAge.getText());
		String home = tfHome.getText();
		
		//(2) 1번의 값들을 InfoVO에 지정 -(1) 생성자 (2) setter
		//setter이용
		InfoVO vo = new InfoVO();
		vo.setName(name);
		vo.setId(id);
		vo.setTel(tel);
		vo.setGender(gender);
		vo.setAge(age);
		vo.setHome(home);
		
		//생성자 이용
		//InfoVO vo = new InfoVO(name, id, tel, gender, age,home);
		
		//(3) 모델의 insertInfo() 호출
		try {
			model.insertInfo(vo);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		//(4) 화면의 입력값들을 지우기
		clearText();
		
	}//end of insertData
	
	/* 함수명 : clearText
	 * 인자 : 없음
	 * 리턴값 : void
	 * 역할 : 내용을 지우는 역할 */
	void clearText() {
		tfName.setText(null);  //내용을 지우겠다는 명령어
		tfId.setText(null);
		tfTel.setText(null);
		tfGender.setText(null);
		tfAge.setText(null);
		tfHome.setText(null);
	}
	
	public static void main(String[] args) {
		InfoView info = new InfoView();
		info.addLayout();
		info.eventProc();
	}
}
