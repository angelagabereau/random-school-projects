package angela;

///////////////////////////////////////////////////////////
//Angela Gabereau
//ID# 4867815
//CART 363 - Advanced Languages of Programming
//Assignment 5 - subtle shifts
//April 12, 2007
///////////////////////////////////////////////////////////

import java.io.*;
import java.awt.*;
import java.awt.image.*;
import javax.swing.*;
import java.awt.event.*;
import java.util.*;


/*This class manipulates a BufferedImage, theDrawingBuffer, by changing individual pixels 
 * of theDrawingBuffer using mutator objects.  Mutator objects select 
 * a BufferedImage from an array of BufferedImages, bImageStack, and then 
 * gets the color of the pixel from that layer at it's x,y coordinates and then changes the pixel 
 * at the same x, y coordinates on the drawingbuffer to the color from the BufferedImage from bImageStack.
 * 
 */
public class subtleShifts extends JComponent {

	static subtleShifts theComp;

	static MediaTracker mt;

	// an array of buffers
	static BufferedImage[] bImageStack;

	// Buffer for actual drawing
	static BufferedImage theDrawingBuffer;

	static int width = 600;

	static int height = 600;

	static int NUM_LAYERS = 6;

	static Image[] imageStack = new Image[NUM_LAYERS];
	static Image titleImage;

	static int NUM_MUTATORS = 10000;

	//an array which contains the  mutator objects
	static Mutator mutators[] = new Mutator[NUM_MUTATORS];

	//timer variables
	private static final int UPDATE_INTERVAL = 500; // Millisecs

	private javax.swing.Timer _timer;

	public subtleShifts() {

		super();
		setPreferredSize(new Dimension(600, 600));

		//intilaize mutators
		for (int i = 0; i < NUM_MUTATORS; ++i)
			mutators[i] = new Mutator(width, height, NUM_LAYERS);

		_timer = new javax.swing.Timer(UPDATE_INTERVAL, new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				shift();
			}
		});
	}

	public void paint(Graphics g) {

		g.setColor(Color.black);
		g.fillRect(0, 0, 600, 600);
		g.setColor(Color.white);

		if (mt == null) {
			g.drawString("Loading Images", 20, 20);
		} else {
			// Check to see if images have loaded
			if (mt.checkAll()) {
				g.drawImage(theDrawingBuffer, 0, 0, this);
				_timer.start();
			} else {
				// Still loading
				g.drawString("Images still are loading...", 20, 20);
			}
		}
	}

	public static void shift() {

		//for each mutator
		for (int i = 0; i < NUM_MUTATORS; ++i) {
			int oldX;
			int oldY;
			int newX;
			int newY;
			int pixel;
			int currentLayer;
			int newLayer;
			oldX = mutators[i].getX();
			oldY = mutators[i].getY();

			//mutator takes a step
			mutators[i].step();
			//get new xy co-ords
			newX = mutators[i].getX();
			newY = mutators[i].getY();
			//get color of pixel on drawing layer at x, y.
			pixel = theDrawingBuffer.getRGB(newX, newY);
			//mutate this pixel to get new layer
			newLayer = mutators[i].mutate(pixel);
			//set the RGB of current pixel to pixel from new layer
			theDrawingBuffer.setRGB(newX, newY, bImageStack[newLayer].getRGB(
					newX, newY));
		}

		theComp.repaint();
	}

	public static void main(String[] args) {

		JFrame myFrame = new JFrame(
				"                                             subtle shifts-----------------");

		myFrame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);

		try {
			imageStack[0] = Toolkit.getDefaultToolkit().getImage("tile1.jpg");
			imageStack[1] = Toolkit.getDefaultToolkit().getImage("tile2.jpg");
			imageStack[2] = Toolkit.getDefaultToolkit().getImage("tile3.jpg");
			imageStack[3] = Toolkit.getDefaultToolkit().getImage("tile4.jpg");
			imageStack[4] = Toolkit.getDefaultToolkit().getImage("tile5.jpg");
			imageStack[5] = Toolkit.getDefaultToolkit().getImage("stall.jpg");
			titleImage = Toolkit.getDefaultToolkit().getImage(
					"titlestall.jpg");
		} catch (Exception e) {
			e.printStackTrace();
		}
		theComp = new subtleShifts();

		// create a media tracker
		mt = new MediaTracker(theComp);

		// associate the image with the ID
		int imageID;
		for (int i = 0; i < NUM_LAYERS; ++i) {
			imageID = i;
			mt.addImage(imageStack[i], imageID);
		}
		imageID = NUM_LAYERS;
		mt.addImage(titleImage, imageID);

		// wait for the image to be loaded
		try {
			mt.waitForAll();
		} catch (Exception e) {
			e.printStackTrace( );
		}

		//CREATE BUFFERED IMAGE STACK
		bImageStack = new BufferedImage[NUM_LAYERS];

		for (int i = 0; i < NUM_LAYERS; ++i) {
			// create a buffered image
			bImageStack[i] = new BufferedImage(width, height,
					BufferedImage.TYPE_INT_RGB);
		}

		// create a buffered image
		theDrawingBuffer = new BufferedImage(width, height,
				BufferedImage.TYPE_INT_RGB);

		// Use Graphics2D to draw the image to the Image Buffer
		Graphics2D imageGraphics;
		for (int i = 0; i < NUM_LAYERS; ++i) {

			bImageStack[i] = new BufferedImage(width, height,
					BufferedImage.TYPE_INT_RGB);
			imageGraphics = bImageStack[i].createGraphics();
			imageGraphics.drawImage(imageStack[i], 0, 0, null);
		}

		imageGraphics = theDrawingBuffer.createGraphics();
		imageGraphics.drawImage(titleImage, 0, 0, null);

		myFrame.getContentPane().setLayout(new BorderLayout());
		myFrame.getContentPane().add(theComp, "Center");
		myFrame.pack();
		myFrame.setVisible(true);
	}
}
