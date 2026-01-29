package utilitarios

import com.itextpdf.kernel.pdf.PdfReader
import com.itextpdf.signatures.PdfSignatureAppearance
//import com.itextpdf.text.DocumentException
//import com.itextpdf.text.pdf.PdfStamper
import com.itextpdf.text.pdf.security.*
import com.itextpdf.kernel.geom.Rectangle
import com.itextpdf.signatures.SignatureUtil
import com.itextpdf.signatures.PdfPKCS7
import com.sun.xml.internal.messaging.saaj.util.ByteOutputStream
import org.bouncycastle.jce.provider.BouncyCastleProvider;

import java.io.FileInputStream
import java.io.FileOutputStream
import java.io.IOException;
import java.security.KeyStore;
import java.security.PrivateKey
import java.security.Security
import java.security.cert.Certificate;
import java.util.Calendar;

class PdfService {

    static transactional = false



//        public static void main(String[] args) throws GeneralSecurityException, IOException, DocumentException {
    def firma() {
        String SRC = "/var/bitacora/hoja.pdf"
        String DEST = "/var/bitacora/firmas/salida.pdf"
        String KEYSTORE = "/var/bitacora/guido.p12"
        char[] PASSWORD = "GdoEdu8aMo"

        BouncyCastleProvider provider = new BouncyCastleProvider();
        Security.addProvider(provider);

        // Cargar el certificado P12
//        KeyStore ks = KeyStore.getInstance("PKCS12");
        KeyStore ks = KeyStore.getInstance("pkcs12", provider.getName());
//        ks.load(new FileInputStream(KEYSTORE), PASSWORD);
        println "...1"
        ks.load(new FileInputStream(KEYSTORE), PASSWORD);
        String alias = ks.aliases().nextElement();
        PrivateKey pk = (PrivateKey) ks.getKey(alias, PASSWORD);
        Certificate[] chain = ks.getCertificateChain(alias);

        // Crear el lector y el escritor de PDF
        PdfReader reader = new PdfReader(SRC);
        FileOutputStream os = new FileOutputStream(DEST);
//        ByteArrayOutputStream output = new ByteArrayOutputStream()
//        PdfStamper stamper = PdfStamper.createSignature(reader, os, '\0');
        char ad = '\0'
        boolean si = true
//        PdfStamper stamper = PdfStamper.createSignature( reader, os, '\0', null, true );

        FileOutputStream fout = new FileOutputStream(DEST);
//        PdfStamper stp = PdfStamper.createSignature(reader, fout, '\0', null, true);
//        PdfStamper stp = new PdfStamper()
        stp.createSignature(reader, fout)


        // Crear el diccionario de firma
        PdfSignatureAppearance appearance = stamper.getSignatureAppearance();
        appearance.setReason("Razón de la firma");
        appearance.setLocation("Ubicación de la firma");
//            appearance.setVisibleSignature(new Rectangle(36, 748, 144, 780), 1, "sig");

        // Crear el diccionario de firma digital
//        ExternalSignature pks = new PrivateKeySignature(pk, DigestAlgorithms.SHA256, provider.getName());
//        ExternalDigest digest = new BouncyCastleDigest();
        MakeSignature.signDetached(appearance, digest, pks, chain, null, null, null, 0, MakeSignature.CryptoStandard.CMS);

    }
//        }

}
