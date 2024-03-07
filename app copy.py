from flask import Flask, request, jsonify

app = Flask(__name__)

@app.route('/api/hello', methods=['POST'])
def get_hello():
    try:
        data = request.json

        if 'name' in data:
            name = data['name']
            response = {"message": f"Hello {name}"}
        elif 'number' in data:
            number = data['number']
            if number == 1:
                response = {"message": "Ebtisam"}
            else:
                response = {"message": "Invalid number"}
        else:
            response = {"error": "Invalid request format"}

        #Returning JSON Response
        return jsonify(response)
    
    except Exception as e:
        return jsonify({"error": str(e)})

#Running the Application
if __name__ == '__main__':
    app.run(debug=True)
