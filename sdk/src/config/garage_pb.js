// source: garage.proto
/**
 * @fileoverview
 * @enhanceable
 * @suppress {missingRequire} reports error on implicit type usages.
 * @suppress {messageConventions} JS Compiler reports an error if a variable or
 *     field starts with 'MSG_' and isn't a translatable message.
 * @public
 */
// GENERATED CODE -- DO NOT EDIT!
/* eslint-disable */
// @ts-nocheck

var jspb = require('google-protobuf');
var goog = jspb;
var global =
    (typeof globalThis !== 'undefined' && globalThis) ||
    (typeof window !== 'undefined' && window) ||
    (typeof global !== 'undefined' && global) ||
    (typeof self !== 'undefined' && self) ||
    (function () { return this; }).call(null) ||
    Function('return this')();

goog.exportSymbol('proto.garaga.GaragaRequest', null, global);
goog.exportSymbol('proto.garaga.GaragaResponse', null, global);
/**
 * Generated by JsPbCodeGenerator.
 * @param {Array=} opt_data Optional initial data array, typically from a
 * server response, or constructed directly in Javascript. The array is used
 * in place and becomes part of the constructed object. It is not cloned.
 * If no data is provided, the constructed object will be empty, but still
 * valid.
 * @extends {jspb.Message}
 * @constructor
 */
proto.garaga.GaragaRequest = function(opt_data) {
  jspb.Message.initialize(this, opt_data, 0, -1, null, null);
};
goog.inherits(proto.garaga.GaragaRequest, jspb.Message);
if (goog.DEBUG && !COMPILED) {
  /**
   * @public
   * @override
   */
  proto.garaga.GaragaRequest.displayName = 'proto.garaga.GaragaRequest';
}
/**
 * Generated by JsPbCodeGenerator.
 * @param {Array=} opt_data Optional initial data array, typically from a
 * server response, or constructed directly in Javascript. The array is used
 * in place and becomes part of the constructed object. It is not cloned.
 * If no data is provided, the constructed object will be empty, but still
 * valid.
 * @extends {jspb.Message}
 * @constructor
 */
proto.garaga.GaragaResponse = function(opt_data) {
  jspb.Message.initialize(this, opt_data, 0, -1, null, null);
};
goog.inherits(proto.garaga.GaragaResponse, jspb.Message);
if (goog.DEBUG && !COMPILED) {
  /**
   * @public
   * @override
   */
  proto.garaga.GaragaResponse.displayName = 'proto.garaga.GaragaResponse';
}



if (jspb.Message.GENERATE_TO_OBJECT) {
/**
 * Creates an object representation of this proto.
 * Field names that are reserved in JavaScript and will be renamed to pb_name.
 * Optional fields that are not set will be set to undefined.
 * To access a reserved field use, foo.pb_<name>, eg, foo.pb_default.
 * For the list of reserved names please see:
 *     net/proto2/compiler/js/internal/generator.cc#kKeyword.
 * @param {boolean=} opt_includeInstance Deprecated. whether to include the
 *     JSPB instance for transitional soy proto support:
 *     http://goto/soy-param-migration
 * @return {!Object}
 */
proto.garaga.GaragaRequest.prototype.toObject = function(opt_includeInstance) {
  return proto.garaga.GaragaRequest.toObject(opt_includeInstance, this);
};


/**
 * Static version of the {@see toObject} method.
 * @param {boolean|undefined} includeInstance Deprecated. Whether to include
 *     the JSPB instance for transitional soy proto support:
 *     http://goto/soy-param-migration
 * @param {!proto.garaga.GaragaRequest} msg The msg instance to transform.
 * @return {!Object}
 * @suppress {unusedLocalVariables} f is only used for nested messages
 */
proto.garaga.GaragaRequest.toObject = function(includeInstance, msg) {
  var f, obj = {
    proof: jspb.Message.getFieldWithDefault(msg, 1, ""),
    input: jspb.Message.getFieldWithDefault(msg, 2, "")
  };

  if (includeInstance) {
    obj.$jspbMessageInstance = msg;
  }
  return obj;
};
}


/**
 * Deserializes binary data (in protobuf wire format).
 * @param {jspb.ByteSource} bytes The bytes to deserialize.
 * @return {!proto.garaga.GaragaRequest}
 */
proto.garaga.GaragaRequest.deserializeBinary = function(bytes) {
  var reader = new jspb.BinaryReader(bytes);
  var msg = new proto.garaga.GaragaRequest;
  return proto.garaga.GaragaRequest.deserializeBinaryFromReader(msg, reader);
};


/**
 * Deserializes binary data (in protobuf wire format) from the
 * given reader into the given message object.
 * @param {!proto.garaga.GaragaRequest} msg The message object to deserialize into.
 * @param {!jspb.BinaryReader} reader The BinaryReader to use.
 * @return {!proto.garaga.GaragaRequest}
 */
proto.garaga.GaragaRequest.deserializeBinaryFromReader = function(msg, reader) {
  while (reader.nextField()) {
    if (reader.isEndGroup()) {
      break;
    }
    var field = reader.getFieldNumber();
    switch (field) {
    case 1:
      var value = /** @type {string} */ (reader.readString());
      msg.setProof(value);
      break;
    case 2:
      var value = /** @type {string} */ (reader.readString());
      msg.setInput(value);
      break;
    default:
      reader.skipField();
      break;
    }
  }
  return msg;
};


/**
 * Serializes the message to binary data (in protobuf wire format).
 * @return {!Uint8Array}
 */
proto.garaga.GaragaRequest.prototype.serializeBinary = function() {
  var writer = new jspb.BinaryWriter();
  proto.garaga.GaragaRequest.serializeBinaryToWriter(this, writer);
  return writer.getResultBuffer();
};


/**
 * Serializes the given message to binary data (in protobuf wire
 * format), writing to the given BinaryWriter.
 * @param {!proto.garaga.GaragaRequest} message
 * @param {!jspb.BinaryWriter} writer
 * @suppress {unusedLocalVariables} f is only used for nested messages
 */
proto.garaga.GaragaRequest.serializeBinaryToWriter = function(message, writer) {
  var f = undefined;
  f = message.getProof();
  if (f.length > 0) {
    writer.writeString(
      1,
      f
    );
  }
  f = message.getInput();
  if (f.length > 0) {
    writer.writeString(
      2,
      f
    );
  }
};


/**
 * optional string proof = 1;
 * @return {string}
 */
proto.garaga.GaragaRequest.prototype.getProof = function() {
  return /** @type {string} */ (jspb.Message.getFieldWithDefault(this, 1, ""));
};


/**
 * @param {string} value
 * @return {!proto.garaga.GaragaRequest} returns this
 */
proto.garaga.GaragaRequest.prototype.setProof = function(value) {
  return jspb.Message.setProto3StringField(this, 1, value);
};


/**
 * optional string input = 2;
 * @return {string}
 */
proto.garaga.GaragaRequest.prototype.getInput = function() {
  return /** @type {string} */ (jspb.Message.getFieldWithDefault(this, 2, ""));
};


/**
 * @param {string} value
 * @return {!proto.garaga.GaragaRequest} returns this
 */
proto.garaga.GaragaRequest.prototype.setInput = function(value) {
  return jspb.Message.setProto3StringField(this, 2, value);
};





if (jspb.Message.GENERATE_TO_OBJECT) {
/**
 * Creates an object representation of this proto.
 * Field names that are reserved in JavaScript and will be renamed to pb_name.
 * Optional fields that are not set will be set to undefined.
 * To access a reserved field use, foo.pb_<name>, eg, foo.pb_default.
 * For the list of reserved names please see:
 *     net/proto2/compiler/js/internal/generator.cc#kKeyword.
 * @param {boolean=} opt_includeInstance Deprecated. whether to include the
 *     JSPB instance for transitional soy proto support:
 *     http://goto/soy-param-migration
 * @return {!Object}
 */
proto.garaga.GaragaResponse.prototype.toObject = function(opt_includeInstance) {
  return proto.garaga.GaragaResponse.toObject(opt_includeInstance, this);
};


/**
 * Static version of the {@see toObject} method.
 * @param {boolean|undefined} includeInstance Deprecated. Whether to include
 *     the JSPB instance for transitional soy proto support:
 *     http://goto/soy-param-migration
 * @param {!proto.garaga.GaragaResponse} msg The msg instance to transform.
 * @return {!Object}
 * @suppress {unusedLocalVariables} f is only used for nested messages
 */
proto.garaga.GaragaResponse.toObject = function(includeInstance, msg) {
  var f, obj = {
    code: jspb.Message.getFieldWithDefault(msg, 1, 0),
    calldata: jspb.Message.getFieldWithDefault(msg, 2, "")
  };

  if (includeInstance) {
    obj.$jspbMessageInstance = msg;
  }
  return obj;
};
}


/**
 * Deserializes binary data (in protobuf wire format).
 * @param {jspb.ByteSource} bytes The bytes to deserialize.
 * @return {!proto.garaga.GaragaResponse}
 */
proto.garaga.GaragaResponse.deserializeBinary = function(bytes) {
  var reader = new jspb.BinaryReader(bytes);
  var msg = new proto.garaga.GaragaResponse;
  return proto.garaga.GaragaResponse.deserializeBinaryFromReader(msg, reader);
};


/**
 * Deserializes binary data (in protobuf wire format) from the
 * given reader into the given message object.
 * @param {!proto.garaga.GaragaResponse} msg The message object to deserialize into.
 * @param {!jspb.BinaryReader} reader The BinaryReader to use.
 * @return {!proto.garaga.GaragaResponse}
 */
proto.garaga.GaragaResponse.deserializeBinaryFromReader = function(msg, reader) {
  while (reader.nextField()) {
    if (reader.isEndGroup()) {
      break;
    }
    var field = reader.getFieldNumber();
    switch (field) {
    case 1:
      var value = /** @type {number} */ (reader.readInt32());
      msg.setCode(value);
      break;
    case 2:
      var value = /** @type {string} */ (reader.readString());
      msg.setCalldata(value);
      break;
    default:
      reader.skipField();
      break;
    }
  }
  return msg;
};


/**
 * Serializes the message to binary data (in protobuf wire format).
 * @return {!Uint8Array}
 */
proto.garaga.GaragaResponse.prototype.serializeBinary = function() {
  var writer = new jspb.BinaryWriter();
  proto.garaga.GaragaResponse.serializeBinaryToWriter(this, writer);
  return writer.getResultBuffer();
};


/**
 * Serializes the given message to binary data (in protobuf wire
 * format), writing to the given BinaryWriter.
 * @param {!proto.garaga.GaragaResponse} message
 * @param {!jspb.BinaryWriter} writer
 * @suppress {unusedLocalVariables} f is only used for nested messages
 */
proto.garaga.GaragaResponse.serializeBinaryToWriter = function(message, writer) {
  var f = undefined;
  f = message.getCode();
  if (f !== 0) {
    writer.writeInt32(
      1,
      f
    );
  }
  f = message.getCalldata();
  if (f.length > 0) {
    writer.writeString(
      2,
      f
    );
  }
};


/**
 * optional int32 code = 1;
 * @return {number}
 */
proto.garaga.GaragaResponse.prototype.getCode = function() {
  return /** @type {number} */ (jspb.Message.getFieldWithDefault(this, 1, 0));
};


/**
 * @param {number} value
 * @return {!proto.garaga.GaragaResponse} returns this
 */
proto.garaga.GaragaResponse.prototype.setCode = function(value) {
  return jspb.Message.setProto3IntField(this, 1, value);
};


/**
 * optional string calldata = 2;
 * @return {string}
 */
proto.garaga.GaragaResponse.prototype.getCalldata = function() {
  return /** @type {string} */ (jspb.Message.getFieldWithDefault(this, 2, ""));
};


/**
 * @param {string} value
 * @return {!proto.garaga.GaragaResponse} returns this
 */
proto.garaga.GaragaResponse.prototype.setCalldata = function(value) {
  return jspb.Message.setProto3StringField(this, 2, value);
};


goog.object.extend(exports, proto.garaga);