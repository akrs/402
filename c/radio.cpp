#include <amqpcpp.h>

class MyTcpHandler : public AMQP::TcpHandler
{
    /**
     *  Method that is called by the AMQP library when the login attempt
     *  succeeded. After this method has been called, the connection is ready
     *  to use.
     *  @param  connection      The connection that can now be used
     */
    virtual void onConnected(AMQP::TcpConnection *connection)
    {
        // and create a channel
        AMQP::TcpChannel channel(connection);

        // use the channel object to call the AMQP method you like
        channel.declareExchange("my-exchange", AMQP::fanout);
        channel.declareQueue("my-queue");
        channel.bindQueue("my-exchange", "my-queue", "my-routing-key");

    }

    /**
     *  Method that is called by the AMQP library when a fatal error occurs
     *  on the connection, for example because data received from RabbitMQ
     *  could not be recognized.
     *  @param  connection      The connection on which the error occured
     *  @param  message         A human readable error message
     */
    virtual void onError(AMQP::TcpConnection *connection, const char *message)
    {
        // @todo
        // Should probably log this...
    }

    /**
     *  Method that is called when the connection was closed. This is the
     *  counter part of a call to Connection::close() and it confirms that the
     *  connection was correctly closed.
     *
     *  @param  connection      The connection that was closed and that is now unusable
     */
    virtual void onClosed(AMQP::TcpConnection *connection) {}

    /**
     *  Method that is called by the AMQP-CPP library when it wants to interact
     *  with the main event loop. The AMQP-CPP library is completely non-blocking,
     *  and only make "write()" or "read()" system calls when it knows in advance
     *  that these calls will not block. To register a filedescriptor in the
     *  event loop, it calls this "monitor()" method with a filedescriptor and
     *  flags telling whether the filedescriptor should be checked for reaability
     *  or writability.
     *
     *  @param  connection      The connection that wants to interact with the event loop
     *  @param  fd              The filedescriptor that should be checked
     *  @param  flags           Bitwise or of AMQP::readable and/or AMQP::writable
     */
    virtual void monitor(AMQP::TcpConnection *connection, int fd, int flags)
    {
        // @todo
        //  add your own implementation, for example by adding the file
        //  descriptor to the main application event loop (like the select() or
        //  poll() loop). When the event loop reports that the descriptor becomes
        //  readable and/or writable, it is up to you to inform the AMQP-CPP
        //  library that the filedescriptor is active by calling the
        //  connection->process(fd, flags) method.
    }
};


int main(int argc, char const *argv[]) {
    // Setup radio and AQMP handlers, read in values from SQLlite DB

    // Setup AQMP
    // create an instance of your own tcp handler
    MyTcpHandler myHandler;

    // address of the server
    AMQP::Address address("amqp://guest:guest@localhost/vhost");

    // create a AMQP connection object
    AMQP::TcpConnection connection(&myHandler, address);


    return 0;
}
