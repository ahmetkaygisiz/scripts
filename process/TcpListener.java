package au.com.flyingkite.tcplistener;

import java.net.ServerSocket;
import java.net.Socket;

public class TcpListener {

	public static void main(final String args[]) throws Exception {

		int clientId = 0;

		if (args.length == 0) {
			printUsage();
			return;
		}

		final int port = Integer.parseInt(args[0]);
		final ServerSocket server = new ServerSocket(port);
		System.out.println("Listening on port: " + port);

		while (true) {

			final Socket clientSocket = server.accept(); // will block until receives connection

			clientId++; // increment this for the client id

			System.out.println("Client " + clientId + " connected from " + clientSocket.getInetAddress());

			final ClientProcessor processor = new ClientProcessor(clientId, clientSocket);
			final Thread t = new Thread(processor);
			t.start();
		}

	}

}
