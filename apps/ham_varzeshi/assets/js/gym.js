let gym = {
    init(socket) {
        let channel = socket.channel('gym:', {})
        channel.join()
        this.listenForChats(channel)
    },

    listenForChats(channel) {
        document.getElementById('chat-form').addEventListener('submit', function(e) {
            e.preventDefault()

            let userMsg = document.getElementById('user-msg').value

            channel.push('msg', { body: userMsg })

            document.getElementById('user-msg').value = ''
        })

        channel.on('msg', payload => {
            let chatBox = document.querySelector('#chat-box')
            let msgBlock = document.createElement('p')

            msgBlock.insertAdjacentHTML('beforeend', `${payload.body}`)
            chatBox.appendChild(msgBlock)
        })
    }
}

export default Gym