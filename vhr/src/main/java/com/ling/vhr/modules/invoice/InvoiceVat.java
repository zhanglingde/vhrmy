package com.ling.vhr.modules.invoice;


import lombok.Data;
import org.dromara.easyes.annotation.IndexField;
import org.dromara.easyes.annotation.IndexName;

@Data
@IndexName("invoice_vat")
public class InvoiceVat {

    private String _id;

    @IndexField(value = "es_code")
    private String esCode;

    @IndexField(value = "invoice_number")
    private String invoiceNumber;
}
