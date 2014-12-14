
import java.io.*;
import java.awt.*;

import javax.swing.*;
import java.awt.event.*;
import java.awt.geom.*;

public class AngelaA4v3 extends JComponent {

	static LSys lsys;

	static int MAX_INDEX = 20000;

	static float[][] paintData = new float[MAX_INDEX][6];// color type is at

	// index [_][0],
	// originX[_][1],
	// originY[_][1],endX[_][1],endY[_][1]
	static private int storageIndex = 0;// stores the axiom of the location in
										// paintData

	// that the next char data from production can
	// be stored.

	static private float HEIGHT = 800;

	static private float WIDTH = 1000;

	static private float HEIGHT_CENTER = HEIGHT / 2;// + HEIGHT/10;

	static private float WIDTH_CENTER = WIDTH / 2;

	static private float segmentLength = 60;

	public AngelaA4v3() {
		super();

		// for a reason i need to find out Dimension constructor will not
		// take vars HEIGHT and WIDTH
		setPreferredSize(new Dimension((int) WIDTH, (int) HEIGHT));
	}

	public void paint(Graphics g) {

		// Cast the graphics to type Graphics2D
		Graphics2D twoDG = (Graphics2D) g;

		Shape bkgd = new Rectangle2D.Float(0f, 0f, WIDTH, HEIGHT);// background

		// set the stroke
		twoDG.setStroke(new BasicStroke(1));

		// paint the fill and outline for the background
		twoDG.setPaint(new Color(238, 238, 209));// light yellow 1
		twoDG.setPaint(Color.black);
		twoDG.fill(bkgd);

		Line2D.Float segment = new Line2D.Float(WIDTH_CENTER, HEIGHT_CENTER,
				WIDTH_CENTER, HEIGHT_CENTER);

		float ellipseType;
		int eSizeFactor = 2;
		Shape e;
		int alpha = 255;

		for (int i = 0; i < storageIndex; i++) {

			twoDG.setPaint(new Color(255, 255, 255, alpha));
			segment.setLine(paintData[i][1], paintData[i][2], paintData[i][3],
					paintData[i][4]);
			twoDG.draw(segment);

			ellipseType = paintData[i][0];

			if (ellipseType == 1) {
				twoDG.setPaint(new Color(205, 16, 118, alpha));// deep pink3
			} else if (ellipseType == 2) {
				twoDG.setPaint(new Color(178, 223, 238, alpha));// light blue2
			} else if (ellipseType == 3) {
				twoDG.setPaint(new Color(127, 255, 0, alpha));// chartreuse1
			} else {
				twoDG.setPaint(new Color(238, 238, 209, alpha));// yellow bkgd
			}
			if (alpha > 10)
				alpha -= 1;
			eSizeFactor = 2;
			e = new Ellipse2D.Float(paintData[i][3] - segmentLength
					/ (2 * eSizeFactor), paintData[i][4] - segmentLength
					/ (2 * eSizeFactor), segmentLength / eSizeFactor,
					segmentLength / eSizeFactor);
			twoDG.fill(e);
			twoDG.setPaint(Color.black);
			twoDG.draw(e);

		}

	}

	// this method calculates all the necessary data to visualize the l-sys
	public static void getPaintData() {

		System.out.println();
		System.out.println("Entering getPaintData");

		int depth = lsys.getDepth();
		String axiom = lsys.getAxiom();
		int startIndex = 0;// stores the index of the first char in current
		// axiom, in paintData
		int endIndex = 0;// stores the index of the last char in current
		// axiom, in paintData, rather the location based
		// the last char, open interval [ )

		float originX = WIDTH_CENTER;
		float originY = HEIGHT_CENTER;
		float endX = originX;
		float endY = originY;

		// for the first entry, the origin, set everything to default.
		paintData[storageIndex][0] = 0;
		paintData[storageIndex][1] = originX;
		paintData[storageIndex][2] = originY;
		paintData[storageIndex][3] = endX;
		paintData[storageIndex][4] = endY;
		paintData[storageIndex][5] = 0;
		++storageIndex;

		// store char data and origin co-ordiantes in paintData
		startIndex = storageIndex;
		storeSegmentCharData(axiom, originX, originY);
		endIndex = storageIndex;
		calculateSegmentData(startIndex, endIndex);

		System.out.println("depth: " + depth);
		for (int j = 0; j < depth; ++j) {

			System.out.println();
			System.out.println("We are at depth: " + j);
			System.out.println();
			// if(paintData.length<1999){
			System.out.println("size of printData: " + storageIndex);
			calculateSegmentData(startIndex, endIndex);
			applyProduction(startIndex, endIndex);
			startIndex = endIndex;
			endIndex = storageIndex;
			// }
		}
		calculateSegmentData(startIndex, endIndex);

	}

	// this method calculate the end points for the segments in paintData in
	// range
	// [start,end).
	public static void calculateSegmentData(int start, int end) {

		System.out.println("calculate segment data start to end" + start
				+ " to " + end);

		int numSegments = end - start;
		;
		float opposite;
		float adajacent;
		int index = start;

		// for each line segment calculate the end co-ordinates using trig
		// and the segmentAngle
		while (index < end) {

			float angle = paintData[index][5];

			if ((angle == 0 || angle == 3.1415927) && index % 2 == 0)
				angle += Math.PI / 4;
			if ((angle == 0) && index % 2 == 0)
				angle -= Math.PI / 4;
			// System.out.println("angle: "+ angle);
			opposite = segmentLength * (float) Math.sin(angle);
			adajacent = segmentLength * (float) Math.cos(angle);

			// store end points
			if (adajacent > 0.5 || adajacent < -0.5) {
				paintData[index][3] = paintData[index][1] + adajacent;
			} else {
				paintData[index][3] = paintData[index][1];
			}

			if (opposite > 0.5 || opposite < -0.5) {
				paintData[index][4] = paintData[index][2] + opposite;
			} else {
				paintData[index][4] = paintData[index][2];
			}
			++index;
		}
		return;
	}

	// this method stores the charData for given string in paintData, beginning
	// at sIndex.
	// It also stores the origin X and Y co-ordinates for segment for each char
	// in string, also in paintData
	public static void storeSegmentCharData(String s, float oX, float oY) {

		int numSegments = s.length();
		float segmentAngle = (float) (Math.PI * 2) / numSegments;

		for (int i = 0; i < s.length(); ++i) {
			if (storageIndex < MAX_INDEX) {
				char c = s.charAt(i);
				if (c == 'a') {
					paintData[storageIndex][0] = 1;
				} else if (c == 'b') {
					paintData[storageIndex][0] = 2;
				} else if (c == 'c') {
					paintData[storageIndex][0] = 3;
				}
				paintData[storageIndex][1] = oX;
				paintData[storageIndex][2] = oY;
				paintData[storageIndex][5] = (i) * segmentAngle;
				++storageIndex;
			}
		}
		return;
	}

	// this method applys the production rules for the l-system to each char in
	// paintData in range [start,end)
	// once the [word] returned by production rule application is then stored in
	// paintData begining at the end of paintData.
	public static void applyProduction(int start, int end) {

		int productionIndex = start;
		while (productionIndex != end) {
			float charType = paintData[productionIndex][0];
			String s = "";
			// find convert charType to char.
			if (charType == 1) {
				s = "a";
			} else if (charType == 2) {
				s = "b";
			} else if (charType == 3) {
				s = "c";
			}
			// apply production to char and get word
			String word = lsys.applyProductions(s);
			// store the word and origin X and Y co-ordinates in paintData
			storeSegmentCharData(word, paintData[productionIndex][3],
					paintData[productionIndex][4]);
			++productionIndex;
		}
	}

	public static void main(String[] args) {

		if (args.length == 3) {

			// RETRIEVE,STORE AND DISPLAY L-SYSTEM GIVEN AT COMMAND LINE

			// example of command line format:
			// java JohnnyA3 ex2.lsys a 6

			System.out.println(args[0]);
			System.out.println(args[1]);
			System.out.println(args[2]);
			lsys = new LSys(args[0], args[1], Integer.valueOf(args[2])
					.intValue());
			// lsys = new LSys("fibonacci.lsys", "a",2);
			// open and parse external file containing L-System.
			lsys.GetLSys();

			// display L-System.
			lsys.DisplayLSys();

			getPaintData();

		} else {
			System.out.println("Incorrect arguments given at command line");
		}

		// Create a JFrame to hold everything
		JFrame myFrame = new JFrame("My Frame");

		myFrame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);

		// create an instance of my own container
		AngelaA4v3 theComp = new AngelaA4v3();

		// add it to the frame, show it all.
		myFrame.getContentPane().add(theComp);
		myFrame.pack();
		myFrame.setVisible(true);
	}
}
