package com.iqmsoft;

import org.apache.avro.Schema;
import org.apache.avro.file.DataFileReader;
import org.apache.avro.file.DataFileWriter;
import org.apache.avro.generic.GenericDatumReader;
import org.apache.avro.generic.GenericRecord;
import org.apache.avro.io.DatumReader;
import org.apache.avro.io.DatumWriter;
import org.apache.avro.specific.SpecificDatumWriter;

import java.io.File;
import java.io.IOException;

public class Main {
    public static void main(String[] args) throws IOException {
        Schema schema = new Schema.Parser().parse(Main.class.getResourceAsStream("/Sample.avsc"));

        Test sample = Test.newBuilder()
                .setName("name")
                .build();

        File file = new File(sample.getClass().getName()+".avro");

        DatumWriter<Test> userDatumWriter = new SpecificDatumWriter<Test>(Test.class);
        DataFileWriter<Test> dataFileWriter = new DataFileWriter<Test>(userDatumWriter);
        dataFileWriter.create(sample.getSchema(), file);
        dataFileWriter.append(sample);
        dataFileWriter.close();

        // Deserialize users from disk
        DatumReader<GenericRecord> datumReader = new GenericDatumReader<GenericRecord>(schema);
        DataFileReader<GenericRecord> dataFileReader = new DataFileReader<GenericRecord>(file, datumReader);
        GenericRecord user = null;
        while (dataFileReader.hasNext()) {
            user = dataFileReader.next(user);
            System.out.println(user);
        }
    }
}
