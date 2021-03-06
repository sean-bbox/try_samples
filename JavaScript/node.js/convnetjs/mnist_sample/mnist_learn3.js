"use strict";

const Promise = require('bluebird');
const fs = require('fs');
const shuffle = require('shuffle-array');
const convnetjs = require('convnetjs');

const mnist = require('./parse_mnist');

const readFile = Promise.promisify(fs.readFile);
const writeFile = Promise.promisify(fs.writeFile);

const epoch = parseInt(process.argv[2]);
const batchSize = parseInt(process.argv[3]);
const learningRate = parseFloat(process.argv[4]);
const trainMethod = process.argv[5];

const jsonFile = process.argv[6];
const jsonDestFile = process.argv[7];

const range = n => {
	const res = Array(n);

	for (let i = 0; i < n; i++) {
		res[i] = i;
	}

	return res;
};

const splitArray = (arr, size) => {
	const res = [];

	for (let i = 0; i < Math.ceil(arr.length / size); i++) {
		res.push(arr.slice(i * size, (i + 1) * size));
	}

	return res;
};

Promise.all([
	readFile(jsonFile),
	mnist.parse('train-images.idx3-ubyte', 'train-labels.idx1-ubyte')
]).spread( (json, data) => {

	const net = new convnetjs.Net();
	net.fromJSON(JSON.parse(json));

	const trainer = new convnetjs.Trainer(net, {
		method: trainMethod, 
		batch_size: batchSize, 
		learning_rate: learningRate
	});

	range(epoch).forEach(ep => {
		const idsList = shuffle(range(data.length));

		splitArray(idsList, batchSize).forEach(ids => {

			const res = ids.reduce(
				(acc, i) => {
					const d = data[i];

					acc.loss += trainer.train(d.values, d.label).loss;
					acc.accuracy += (net.getPrediction() == d.label)? 1: 0;

					return acc;
				},
				{ loss: 0.0, accuracy: 0 }
			);

			for (let key in res) {
				res[key] /= ids.length;
			}

			console.log( [ep, res.loss, res.accuracy].join(',') );
		});

		writeFile(jsonDestFile, JSON.stringify(net.toJSON()))
			.error( e => console.error(e) );
	});
});
