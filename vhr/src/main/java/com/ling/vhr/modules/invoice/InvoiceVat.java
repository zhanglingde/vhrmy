package com.ling.vhr.modules.invoice;


import lombok.Data;
import org.dromara.easyes.annotation.IndexName;

@Data
@IndexName("invoice_vat")
public class InvoiceVat {

    private String _id;

    private String esCode;

    private String invoiceNumber;
}
